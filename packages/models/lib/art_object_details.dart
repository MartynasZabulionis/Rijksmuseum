import 'package:json_annotation/json_annotation.dart';

import 'art_object_image.dart';

part 'art_object_details.g.dart';

@JsonSerializable()
class ArtObjectDetails {
  final String title;
  final String principalOrFirstMaker;
  final String? plaqueDescriptionEnglish;
  final ArtObjectImage? webImage;
  final List<String> materials;

  const ArtObjectDetails({
    required this.title,
    required this.principalOrFirstMaker,
    required this.plaqueDescriptionEnglish,
    required this.materials,
    required this.webImage,
  });
  factory ArtObjectDetails.fromJson(Map<String, dynamic> json) => _$ArtObjectDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ArtObjectDetailsToJson(this);
}
