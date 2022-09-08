import 'package:data_sources/api_call_mixin.dart';
import 'package:dio/dio.dart';
import 'package:models/models.dart';

class ArtObjectsRemoteDataSource with ApiCallMixin {
  final Dio dio;

  ArtObjectsRemoteDataSource(this.dio);

  String _getUrl(String subUrl) => '/en/collection$subUrl';

  Future<List<ArtObject>> getArtObjects(int page) async {
    final response = await apiCallWrapper(() {
      return dio.get<Map<String, dynamic>>(
        _getUrl(''),
        queryParameters: {'p': page},
      );
    });

    final json = response.data!;
    final artObjectsData = json['artObjects'] as List<dynamic>;
    return [
      for (final artObjectData in artObjectsData) ArtObject.fromJson(artObjectData),
    ];
  }

  Future<ArtObjectDetails> getArtObjectDetails(String objectNumber) async {
    final response = await apiCallWrapper(() {
      return dio.get<Map<String, dynamic>>(
        _getUrl('/$objectNumber'),
      );
    });

    final json = response.data!;

    return ArtObjectDetails.fromJson(json['artObject']);
  }
}
