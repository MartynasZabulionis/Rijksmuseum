import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rijksmuseum/globals.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/models/art_object_details.dart';

abstract class DataRepository {
  Future<List<ArtObject>> fetchArtObjects();

  Future<ArtObjectDetails> fetchArtObjectDetails(ArtObject artObject);
}

class HttpDataFetcher implements DataRepository {
  final http.Client client;

  HttpDataFetcher(this.client);
  Future<List<ArtObject>> fetchArtObjects() async {
    final response = await client.get(Uri.parse('https://www.rijksmuseum.nl/api/en/collection?key=$API_KEY'));

    final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    return [
      for (final artObjectJson in json['artObjects'])
        ArtObject(
          principalOrFirstMaker: artObjectJson['principalOrFirstMaker'],
          title: artObjectJson['title'],
          headerImgUrl: artObjectJson['hasImage'] ? artObjectJson['headerImage']['url'] : null,
          webImgUrl: artObjectJson['hasImage'] ? artObjectJson['webImage']['url'] : null,
          objectNumber: artObjectJson['objectNumber'],
        ),
    ];
  }

  Future<ArtObjectDetails> fetchArtObjectDetails(ArtObject item) async {
    final response =
        await client.get(Uri.parse('https://www.rijksmuseum.nl/api/en/collection/${item.objectNumber}?key=$API_KEY'));

    final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    final artObjectJson = json['artObject'];
    return ArtObjectDetails(
      plaqueDescriptionEnglish: artObjectJson['plaqueDescriptionEnglish'],
      materials: artObjectJson['materials'].cast<String>(),
    );
  }
}
