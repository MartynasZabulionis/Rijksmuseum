part of 'art_object_cubit.dart';

@immutable
abstract class ArtObjectState {}

class ArtObjectFetching extends ArtObjectState {}

class ArtObjectSuccess extends ArtObjectState {
  final List<ArtObject> artObjects;

  ArtObjectSuccess(this.artObjects);
}

class ArtObjectError extends ArtObjectState {
  final String message;

  ArtObjectError(this.message);
}
