import 'package:data_sources/injector.dart';
import 'package:get_it/get_it.dart';

import 'art_objects_repository.dart';

void registerRepositoriesDependencies() {
  registerDataSourcesDependencies();
  final injector = GetIt.instance;
  injector.registerLazySingleton(() => ArtObjectsRepository(injector()));
}
