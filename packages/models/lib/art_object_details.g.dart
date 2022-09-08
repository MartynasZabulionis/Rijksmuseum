// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_object_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObjectDetails _$ArtObjectDetailsFromJson(Map<String, dynamic> json) => ArtObjectDetails(
      title: json['title'] as String,
      principalOrFirstMaker: json['principalOrFirstMaker'] as String,
      plaqueDescriptionEnglish: json['plaqueDescriptionEnglish'] as String?,
      materials: (json['materials'] as List<dynamic>).map((e) => e as String).toList(),
      webImage: json['webImage'] == null
          ? null
          : ArtObjectImage.fromJson(json['webImage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtObjectDetailsToJson(ArtObjectDetails instance) => <String, dynamic>{
      'title': instance.title,
      'principalOrFirstMaker': instance.principalOrFirstMaker,
      'plaqueDescriptionEnglish': instance.plaqueDescriptionEnglish,
      'webImage': instance.webImage,
      'materials': instance.materials,
    };
