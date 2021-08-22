import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/models/art_object_details.dart';
import 'package:rijksmuseum/services/data_repository.dart';

part 'art_object_details_state.dart';

class ArtObjectDetailsCubit extends Cubit<ArtObjectDetailsState> {
  final DataRepository dataRepository;
  final ArtObject artObject;
  ArtObjectDetailsCubit(this.dataRepository, this.artObject) : super(ArtObjectDetailsFetching());

  void fetchArtObjectDetails() async {
    emit(ArtObjectDetailsFetching());
    try {
      final artObjectDetails = await dataRepository.fetchArtObjectDetails(artObject);
      emit(ArtObjectDetailsSuccess(artObjectDetails));
    } catch (e) {
      emit(ArtObjectDetailsError(e is SocketException ? 'No internet connection' : 'An error occurred'));
    }
  }
}
