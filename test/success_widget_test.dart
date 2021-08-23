import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rijksmuseum/cubit/art_object/art_object_cubit.dart';
import 'package:rijksmuseum/cubit/art_object_details/art_object_details_cubit.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/models/art_object_details.dart';
import 'package:rijksmuseum/screens/art_objects_details_screen/art_object_details_screen.dart';
import 'package:rijksmuseum/screens/art_objects_screen/art_objects_screen.dart';
import 'package:rijksmuseum/services/data_repository.dart';

class _FakeRepository implements DataRepository {
  final Duration fetchingDuration;
  final ArtObject artObject;
  final int artObjectCount;

  _FakeRepository({
    required this.fetchingDuration,
    required this.artObject,
    required this.artObjectCount,
  });

  @override
  Future<ArtObjectDetails> fetchArtObjectDetails(ArtObject artObject) async {
    await Future.delayed(fetchingDuration);
    return ArtObjectDetails(
      plaqueDescriptionEnglish: 'Description',
      materials: ['Material'],
    );
  }

  @override
  Future<List<ArtObject>> fetchArtObjects() async {
    await Future.delayed(fetchingDuration);
    return [
      for (int i = 0; i < artObjectCount; ++i) artObject,
    ];
  }
}

void main() {
  final artObject = ArtObject(
    headerImgUrl: null,
    principalOrFirstMaker: 'Maker',
    objectNumber: '',
    title: 'Title',
    webImgUrl: null,
  );
  final artObjectCount = 3;
  final fetchingDuration = Duration(milliseconds: 10);

  final repository = _FakeRepository(
    fetchingDuration: fetchingDuration,
    artObject: artObject,
    artObjectCount: artObjectCount,
  );

  testWidgets('Art objects screen should show a loading indicator and then a list of art objects',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (_) => ArtObjectCubit(repository)..fetchArtObjects(),
        child: ArtObjectsScreen(),
      ),
    ));

    // Data "fetching" lasts for [loadingDuration].
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(fetchingDuration);

    // Should contain N same art objects
    expect(find.byType(Card), findsNWidgets(artObjectCount));
    expect(find.textContaining(artObject.title), findsNWidgets(artObjectCount));
    expect(find.text(artObject.principalOrFirstMaker), findsNWidgets(artObjectCount));
  });

  testWidgets('Art object details screen should show a loading indicator and then art object\'s detailed data',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (_) => ArtObjectDetailsCubit(repository, artObject)..fetchArtObjectDetails(),
        child: ArtObjectDetailsScreen(),
      ),
    ));

    // Data "fetching" lasts for [loadingDuration].
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(fetchingDuration);

    expect(find.textContaining(artObject.principalOrFirstMaker), findsOneWidget);
    expect(find.text(artObject.title), findsWidgets);
    expect(find.textContaining('Material'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
  });
}
