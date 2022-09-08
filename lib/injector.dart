import 'package:blocs/injector.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;
void registerDependencies() {
  registerBlocsDependencies();
}