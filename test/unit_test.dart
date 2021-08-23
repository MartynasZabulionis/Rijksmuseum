import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rijksmuseum/globals.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/models/art_object_details.dart';
import 'package:rijksmuseum/services/data_repository.dart';

import 'response_json.dart';
import 'unit_test.mocks.dart';

class MockArtObject extends Fake implements ArtObject {
  @override
  final String objectNumber;
  MockArtObject(this.objectNumber);
}

@GenerateMocks([Client])
void main() {
  group('fetchArtObjects', () {
    test('throws an exception if http completes with an error', () async {
      final client = MockClient();
      when(client.get(Uri.parse('https://www.rijksmuseum.nl/api/en/collection?key=$API_KEY')))
          .thenAnswer((_) => throw SocketException(''));
      final repository = HttpDataFetcher(client);
      expect(repository.fetchArtObjects(), throwsException);
    });

    test('returns a list of art ojbects if http call is successful', () async {
      final client = MockClient();
      when(client.get(Uri.parse('https://www.rijksmuseum.nl/api/en/collection?key=$API_KEY')))
          .thenAnswer((_) async => Response(artObjectsResponseJson, 200));
      final repository = HttpDataFetcher(client);
      expect(await repository.fetchArtObjects(), isA<List<ArtObject>>());
    });
  });

  group('fetchArtObjectDetails', () {
    test('throws an exception if http completes with an error', () async {
      final client = MockClient();
      final mockArtObject = MockArtObject('Nr');
      when(client.get(Uri.parse('https://www.rijksmuseum.nl/api/en/collection/Nr?key=$API_KEY')))
          .thenAnswer((_) => throw SocketException(''));
      final repository = HttpDataFetcher(client);
      expect(repository.fetchArtObjectDetails(mockArtObject), throwsException);
    });

    test('returns a list of art ojbects if http call is successful', () async {
      final client = MockClient();
      final mockArtObject = MockArtObject('Nr');
      when(client.get(Uri.parse('https://www.rijksmuseum.nl/api/en/collection/Nr?key=$API_KEY')))
          .thenAnswer((_) async => Response(artObjectDetailsResponseJson, 200));
      final repository = HttpDataFetcher(client);
      expect(await repository.fetchArtObjectDetails(mockArtObject), isA<ArtObjectDetails>());
    });
  });
}
