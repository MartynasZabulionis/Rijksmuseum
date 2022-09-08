import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'art_objects_remote_data_source.dart';

void registerDataSourcesDependencies() {
  final injector = GetIt.instance;
  injector
    ..registerSingleton(_createDio())
    ..registerLazySingleton(() => ArtObjectsRemoteDataSource(injector()));
}

Dio _createDio() {
  return Dio(
    BaseOptions(
      baseUrl: 'https://www.rijksmuseum.nl/api',
      queryParameters: {'key': 'YOUR_API_KEY'},
    ),
  );
}
