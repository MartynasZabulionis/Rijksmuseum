import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rijksmuseum/main.dart';
import 'package:rijksmuseum/models/art_object_details.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/services/data_repository.dart';

class _MockRepository implements DataRepository {
  bool didOccurInternetError = true;
  bool didOccurSomeOtherError = true;

  final Duration loadingDuration;
  final int artObjectsCount;
  _MockRepository(this.loadingDuration, this.artObjectsCount);

  @override
  Future<List<ArtObject>> fetchArtObjects() async {
    await Future.delayed(loadingDuration);

    if (didOccurInternetError) {
      didOccurInternetError = false;
      throw SocketException('');
    }

    return [
      for (int i = 0; i < artObjectsCount; ++i)
        ArtObject(
          principalOrFirstMaker: 'Maker',
          webImgUrl: null,
          title: 'Art',
          headerImgUrl: null,
          objectNumber: '',
        ),
    ];
  }

  @override
  Future<ArtObjectDetails> fetchArtObjectDetails(ArtObject __) async {
    if (didOccurSomeOtherError) {
      didOccurSomeOtherError = false;
      throw 1;
    }
    return ArtObjectDetails(
      plaqueDescriptionEnglish: 'Art object description',
      materials: ['paper'],
    );
  }
}

void main() {
  testWidgets('Art objects and art object details are being loaded with errors and without',
      (WidgetTester tester) async {
    final loadingDuration = Duration(milliseconds: 10);
    final timeToWait = loadingDuration + Duration(milliseconds: 5);
    final artObjectsCount = 2;

    // Initial pump
    await tester.pumpWidget(App(_MockRepository(loadingDuration, artObjectsCount)));

    // Data "fetching" lasts for [loadingDuration].
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(timeToWait);

    expect(find.text('No internet connection'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);

    // Try again to fetch data
    await tester.tap(find.text('Try again'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(timeToWait);

    // Should contain N same art objects
    expect(find.byType(Card), findsNWidgets(artObjectsCount));
    expect(find.textContaining('Maker'), findsNWidgets(artObjectsCount));
    expect(find.text('Art'), findsNWidgets(artObjectsCount));

    // Tap on first art object tile and open details page
    await tester.tap(find.byWidget(tester.firstWidget(find.text('Art'))));
    await tester.pumpAndSettle();
    expect(find.text('An error occurred'), findsOneWidget);

    await tester.tap(find.text('Try again'));
    await tester.pump();

    expect(find.textContaining('paper'), findsOneWidget);
    expect(find.text('Art object description'), findsOneWidget);
  });
}
