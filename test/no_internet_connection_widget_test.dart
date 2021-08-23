import 'dart:io';

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
  @override
  Future<ArtObjectDetails> fetchArtObjectDetails(ArtObject artObject) {
    throw SocketException('');
  }

  @override
  Future<List<ArtObject>> fetchArtObjects() {
    throw SocketException('');
  }
}

void main() {
  final artObject = ArtObject(
    headerImgUrl: null,
    principalOrFirstMaker: '',
    objectNumber: '',
    title: '',
    webImgUrl: null,
  );
  testWidgets('Art objects screen should show "No internet connection"', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (_) => ArtObjectCubit(_FakeRepository())..fetchArtObjects(),
        child: ArtObjectsScreen(),
      ),
    ));
    expect(find.text('No internet connection'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });
  testWidgets('Art object details screen should show "No internet connection"', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (_) => ArtObjectDetailsCubit(_FakeRepository(), artObject)..fetchArtObjectDetails(),
        child: ArtObjectDetailsScreen(),
      ),
    ));
    expect(find.text('No internet connection'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });
}
