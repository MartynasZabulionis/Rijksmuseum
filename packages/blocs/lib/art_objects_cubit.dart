import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:blocs/converters/loading_error_to_message_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:repositories/repositories.dart';

@immutable
// Not using Equatable or freezed purposefully
abstract class ArtObjectsState {
  const ArtObjectsState();
}

class ArtObjectsInitialLoadingState extends ArtObjectsState {
  const ArtObjectsInitialLoadingState();
}

class ArtObjectsInitialLoadingErrorState extends ArtObjectsState {
  final String message;

  const ArtObjectsInitialLoadingErrorState(this.message);
}

class ArtObjectsLoadedState extends ArtObjectsState {
  final UnmodifiableListView<ArtObject> artObjects;
  final bool isLoadingMore;
  final String loadingMoreErrorMessage;

  const ArtObjectsLoadedState({
    required this.artObjects,
    required this.isLoadingMore,
    required this.loadingMoreErrorMessage,
  });
}

class ArtObjectsCubit extends Cubit<ArtObjectsState> {
  final ArtObjectsRepository artObjectsRepository;
  final LoadingErrorToMessageConverter _errorToMessageConverter;
  ArtObjectsCubit(
    this.artObjectsRepository,
    this._errorToMessageConverter,
  ) : super(const ArtObjectsInitialLoadingState()) {
    // _fetchArtObjects();
  }

  int _nextPage = 1;
  final _artObjects = <ArtObject>[];

  void fetchNewArtObjects() async {
    final state = this.state;
    if (state is ArtObjectsLoadedState) {
      emit(ArtObjectsLoadedState(
        artObjects: state.artObjects,
        isLoadingMore: true,
        loadingMoreErrorMessage: '',
      ));
    } else if (state is ArtObjectsInitialLoadingErrorState) {
      emit(const ArtObjectsInitialLoadingState());
    }
    _fetchArtObjects();
  }

  void _fetchArtObjects() async {
    try {
      final artObjects = await artObjectsRepository.getArtObjects(_nextPage);

      _artObjects.addAll(artObjects);
      emit(ArtObjectsLoadedState(
        artObjects: UnmodifiableListView(_artObjects),
        isLoadingMore: false,
        loadingMoreErrorMessage: '',
      ));
      ++_nextPage;
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(Object e) {
    final errorText = _errorToMessageConverter.convert(e);
    final state = this.state;
    if (state is ArtObjectsInitialLoadingState) {
      emit(ArtObjectsInitialLoadingErrorState(errorText));
    } else if (state is ArtObjectsLoadedState) {
      emit(ArtObjectsLoadedState(
        artObjects: state.artObjects,
        isLoadingMore: false,
        loadingMoreErrorMessage: errorText,
      ));
    }
  }
}
