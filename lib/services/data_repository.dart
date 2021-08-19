import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rijksmuseum/globals.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/models/art_object_details.dart';

abstract class DataRepository {
  Future<List<ArtObject>> fetchArtObjects(State? state);

  Future<ArtObjectDetails> fetchArtObjectDetails(State? state, ArtObject item);
}

class HttpDataFetcher implements DataRepository {
  // final Client client;

  // HttpDataFetcher(this.client);

  Future<List<ArtObject>> fetchArtObjects(State? state) async {
    final response = await http.get(Uri.parse('https://www.rijksmuseum.nl/api/en/collection?key=$API_KEY'));

    if (state?.mounted == false) throw 0;

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (state?.mounted == false) throw 0;

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

  Future<ArtObjectDetails> fetchArtObjectDetails(State? state, ArtObject item) async {
    final response =
        await http.get(Uri.parse('https://www.rijksmuseum.nl/api/en/collection/${item.objectNumber}?key=$API_KEY'));

    if (state?.mounted == false) throw 0;

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (state?.mounted == false) throw 0;

    final artObjectJson = json['artObject'];
    return ArtObjectDetails(
      plaqueDescriptionEnglish: artObjectJson['plaqueDescriptionEnglish'],
      materials: artObjectJson['materials'].cast<String>(),
    );
  }
}
