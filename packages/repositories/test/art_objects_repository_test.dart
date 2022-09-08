import 'package:data_sources/data_sources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:models/models.dart';
import 'package:repositories/art_objects_repository.dart';

class ArtObjectsRemoteDataSourceMock extends Mock implements ArtObjectsRemoteDataSource {}

void main() {
  late ArtObjectsRemoteDataSource artObjectsRemoteDataSource;
  late ArtObjectsRepository artObjectsRepository;
  setUp(() {
    artObjectsRemoteDataSource = ArtObjectsRemoteDataSourceMock();
    artObjectsRepository = ArtObjectsRepository(artObjectsRemoteDataSource);
  });

  group('getArtObjects:', () {
    test('gets two art objects', () async {
      when(() => artObjectsRemoteDataSource.getArtObjects(1)).thenAnswer((_) async {
        return [
          for (int i = 0; i < 2; ++i)
            ArtObject(
              principalOrFirstMaker: 'principalOrFirstMaker',
              title: 'title',
              headerImage: const ArtObjectImage(url: 'url'),
              objectNumber: 'objectNumber',
            ),
        ];
      });
      final artObjects = await artObjectsRepository.getArtObjects(1);

      verify(() => artObjectsRemoteDataSource.getArtObjects(1)).called(1);

      expect(artObjects.length, 2);

      final artObject = artObjects.first;
      expect(artObject.title, 'title');
      expect(artObject.objectNumber, 'objectNumber');
      expect(artObject.principalOrFirstMaker, 'principalOrFirstMaker');
      expect(artObject.headerImage!.url, 'url');
    });
  });
  group('getArtObjectDetails:', () {
    test('gets art object details', () async {
      when(() => artObjectsRemoteDataSource.getArtObjectDetails('556')).thenAnswer((_) async {
        return const ArtObjectDetails(
          title: 'title',
          principalOrFirstMaker: 'principalOrFirstMaker',
          plaqueDescriptionEnglish: 'plaqueDescriptionEnglish',
          materials: ['mat1', 'mat2'],
          webImage: ArtObjectImage(url: 'url'),
        );
      });
      final artObjectDetails = await artObjectsRepository.getArtObjectDetails('556');

      verify(() => artObjectsRemoteDataSource.getArtObjectDetails('556')).called(1);

      expect(artObjectDetails.title, 'title');
      expect(artObjectDetails.principalOrFirstMaker, 'principalOrFirstMaker');
      expect(artObjectDetails.plaqueDescriptionEnglish, 'plaqueDescriptionEnglish');
      expect(artObjectDetails.webImage!.url, 'url');
      expect(artObjectDetails.materials, ['mat1', 'mat2']);
    });
  });
}
