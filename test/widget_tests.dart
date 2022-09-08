import 'package:blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';
import 'package:rijksmuseum/screens/art_objects_details_screen/art_object_details_screen.dart';
import 'package:rijksmuseum/screens/art_objects_screen/widgets/art_object_tile.dart';
import 'package:rijksmuseum/widgets/error_text_and_try_again_button.dart';

class FakeArtObjectDetailsCubit extends Fake implements ArtObjectDetailsCubit {
  @override
  final ArtObjectDetailsState state;
  FakeArtObjectDetailsCubit(this.state);
  @override
  Stream<ArtObjectDetailsState> get stream => Stream.value(state);

  @override
  Future<void> close() async {}
}

void main() {
  testWidgets('ArtObjectTile displays title and principalOrFirstMaker texts', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ArtObjectTile(
          ArtObject(
            objectNumber: '',
            title: 'Title',
            principalOrFirstMaker: 'PrincipalOrFirstMaker',
            headerImage: null,
          ),
        ),
      ),
    ));
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('PrincipalOrFirstMaker'), findsOneWidget);
  });

  testWidgets('ErrorTextAndTryAgainButton displays message and Try again texts', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ErrorTextAndTryAgainButton(
          message: 'Msg',
          onPressed: () {},
        ),
      ),
    ));
    expect(find.text('Msg'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('Art object details screen shows error', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<ArtObjectDetailsCubit>(
        create: (_) => FakeArtObjectDetailsCubit(ArtObjectDetailsErrorState('Error text')),
        child: const ArtObjectDetailsScreen(),
      ),
    ));
    expect(find.byType(ErrorTextAndTryAgainButton), findsOneWidget);
    expect(find.text('Error text'), findsOneWidget);
  });
  testWidgets('Art object details screen shows loaded info', (tester) async {
    const artObjectDetails = ArtObjectDetails(
      title: 'title',
      plaqueDescriptionEnglish: 'plaqueDescriptionEnglish',
      principalOrFirstMaker: 'principalOrFirstMaker',
      materials: ['mat1', 'mat2'],
      webImage: null,
    );
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<ArtObjectDetailsCubit>(
        create: (_) => FakeArtObjectDetailsCubit(ArtObjectDetailsLoadedState(artObjectDetails)),
        child: const ArtObjectDetailsScreen(),
      ),
    ));
    expect(find.text('title'), findsNWidgets(2));
    expect(find.text('plaqueDescriptionEnglish'), findsOneWidget);
    expect(find.text('Principal or first maker: principalOrFirstMaker'), findsOneWidget);

    expect(find.text('Materials: mat1, mat2'), findsOneWidget);

    expect(find.byType(ErrorTextAndTryAgainButton), findsNothing);
  });
}
