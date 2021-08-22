import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/services/data_repository.dart';

part 'art_object_state.dart';

class ArtObjectCubit extends Cubit<ArtObjectState> {
  final DataRepository dataRepository;
  ArtObjectCubit(this.dataRepository) : super(ArtObjectFetching());

  void fetchArtObjects() async {
    emit(ArtObjectFetching());
    try {
      final artObjects = await dataRepository.fetchArtObjects();
      emit(ArtObjectSuccess(artObjects));
    } catch (e) {
      emit(ArtObjectError(e is SocketException ? 'No internet connection' : 'An error occurred'));
    }
  }
}
