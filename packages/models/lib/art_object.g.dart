// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObject _$ArtObjectFromJson(Map<String, dynamic> json) => ArtObject(
      principalOrFirstMaker: json['principalOrFirstMaker'] as String,
      title: json['title'] as String,
      headerImage: json['headerImage'] == null
          ? null
          : ArtObjectImage.fromJson(
              json['headerImage'] as Map<String, dynamic>),
      objectNumber: json['objectNumber'] as String,
    );

Map<String, dynamic> _$ArtObjectToJson(ArtObject instance) => <String, dynamic>{
      'title': instance.title,
      'objectNumber': instance.objectNumber,
      'principalOrFirstMaker': instance.principalOrFirstMaker,
      'headerImage': instance.headerImage,
    };
