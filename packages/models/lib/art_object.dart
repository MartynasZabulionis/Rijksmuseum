import 'package:json_annotation/json_annotation.dart';

import 'art_object_image.dart';

part 'art_object.g.dart';

@JsonSerializable()
class ArtObject {
  final String title;
  final String objectNumber;
  final String principalOrFirstMaker;
  final ArtObjectImage? headerImage;

  ArtObject({
    required this.principalOrFirstMaker,
    required this.title,
    required this.headerImage,
    required this.objectNumber,
  });

  factory ArtObject.fromJson(Map<String, dynamic> json) => _$ArtObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ArtObjectToJson(this);
}
