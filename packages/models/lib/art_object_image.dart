import 'package:json_annotation/json_annotation.dart';

part 'art_object_image.g.dart';

@JsonSerializable()
class ArtObjectImage {
  final String url;

  const ArtObjectImage({
    required this.url,
  });
  factory ArtObjectImage.fromJson(Map<String, dynamic> json) => _$ArtObjectImageFromJson(json);

  Map<String, dynamic> toJson() => _$ArtObjectImageToJson(this);
}
