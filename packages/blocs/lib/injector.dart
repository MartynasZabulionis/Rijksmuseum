import 'package:blocs/converters/loading_error_to_message_converter.dart';
import 'package:get_it/get_it.dart';
import 'package:repositories/injector.dart';

import 'art_object_details_cubit.dart';
import 'art_objects_cubit.dart';

void registerBlocsDependencies() {
  registerRepositoriesDependencies();

  final injector = GetIt.instance;
  injector
    ..registerSingleton(LoadingErrorToMessageConverter())
    ..registerFactory(() => ArtObjectsCubit(injector(), injector()))
    ..registerFactoryParam(
        (String objectNumber, _) => ArtObjectDetailsCubit(objectNumber, injector(), injector()));
}
