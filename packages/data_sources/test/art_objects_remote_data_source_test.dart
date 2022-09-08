import 'package:data_sources/art_objects_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dio;
  late ArtObjectsRemoteDataSource artObjectsRemoteDataSource;
  setUp(() {
    dio = DioMock();
    artObjectsRemoteDataSource = ArtObjectsRemoteDataSource(dio);
  });

  group('getArtObjects:', () {
    test('gets two art objects', () async {
      when(() => dio.get<Map<String, dynamic>>('/en/collection', queryParameters: {'p': 1}))
          .thenAnswer((_) async {
        return Response(
          requestOptions: RequestOptions(path: '/en/collection'),
          data: {
            'artObjects': [
              for (int i = 0; i < 2; ++i)
                {
                  'title': 'title',
                  'objectNumber': 'objectNumber',
                  'principalOrFirstMaker': 'principalOrFirstMaker',
                  'headerImage': {'url': 'url'},
                }
            ],
          },
        );
      });
      final artObjects = await artObjectsRemoteDataSource.getArtObjects(1);

      verify(() => dio.get<Map<String, dynamic>>('/en/collection', queryParameters: {'p': 1}))
          .called(1);

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
      when(() => dio.get<Map<String, dynamic>>('/en/collection/566')).thenAnswer((_) async {
        return Response(
          requestOptions: RequestOptions(path: '/en/collection/566'),
          data: {
            'artObject': {
              'title': 'title',
              'principalOrFirstMaker': 'principalOrFirstMaker',
              'plaqueDescriptionEnglish': 'plaqueDescriptionEnglish',
              'webImage': {'url': 'url'},
              'materials': ['mat1', 'mat2'],
            },
          },
        );
      });
      final artObjectDetails = await artObjectsRemoteDataSource.getArtObjectDetails('566');

      verify(() => dio.get<Map<String, dynamic>>('/en/collection/566')).called(1);

      expect(artObjectDetails.title, 'title');
      expect(artObjectDetails.principalOrFirstMaker, 'principalOrFirstMaker');
      expect(artObjectDetails.plaqueDescriptionEnglish, 'plaqueDescriptionEnglish');
      expect(artObjectDetails.webImage!.url, 'url');
      expect(artObjectDetails.materials, ['mat1', 'mat2']);
    });
  });
}
