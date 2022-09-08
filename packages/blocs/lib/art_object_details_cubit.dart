import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:repositories/repositories.dart';

import 'converters/loading_error_to_message_converter.dart';

@immutable
// Not using Equatable or freezed purposefully
abstract class ArtObjectDetailsState {}

class ArtObjectDetailsLoadingState extends ArtObjectDetailsState {}

class ArtObjectDetailsLoadedState extends ArtObjectDetailsState {
  final ArtObjectDetails artObjectDetails;

  ArtObjectDetailsLoadedState(this.artObjectDetails);
}

class ArtObjectDetailsErrorState extends ArtObjectDetailsState {
  final String message;

  ArtObjectDetailsErrorState(this.message);
}

class ArtObjectDetailsCubit extends Cubit<ArtObjectDetailsState> {
  final String objectNumber;
  final ArtObjectsRepository artObjectsRepository;
  final LoadingErrorToMessageConverter _errorToMessageConverter;
  ArtObjectDetailsCubit(
    this.objectNumber,
    this.artObjectsRepository,
    this._errorToMessageConverter,
  ) : super(ArtObjectDetailsLoadingState());

  void fetchArtObjectDetails() async {
    if (state is! ArtObjectDetailsLoadingState) {
      emit(ArtObjectDetailsLoadingState());
    }
    try {
      final artObjectDetails = await artObjectsRepository.getArtObjectDetails(objectNumber);
      emit(ArtObjectDetailsLoadedState(artObjectDetails));
    } catch (e) {
      emit(ArtObjectDetailsErrorState(_errorToMessageConverter.convert(e)));
    }
  }
}
