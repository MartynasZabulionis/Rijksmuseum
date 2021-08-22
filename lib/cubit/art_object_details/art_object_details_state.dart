part of 'art_object_details_cubit.dart';

@immutable
abstract class ArtObjectDetailsState {}

class ArtObjectDetailsFetching extends ArtObjectDetailsState {}

class ArtObjectDetailsSuccess extends ArtObjectDetailsState {
  final ArtObjectDetails artObjectDetails;

  ArtObjectDetailsSuccess(this.artObjectDetails);
}

class ArtObjectDetailsError extends ArtObjectDetailsState {
  final String message;

  ArtObjectDetailsError(this.message);
}
