import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:blocs/art_object_details_cubit.dart';
import 'package:blocs/converters/loading_error_to_message_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repositories/art_objects_repository.dart';

import 'fakes.dart';
import 'mocks.dart';

void main() {
  late ArtObjectsRepository artObjectsRepository;
  late ArtObjectDetailsCubit artObjectDetailsCubit;
  late LoadingErrorToMessageConverter errorToMessageConverter;

  setUp(() {
    artObjectsRepository = ArtObjectsRepositoryMock();
    errorToMessageConverter = LoadingErrorToMessageConverterMock();
    artObjectDetailsCubit = ArtObjectDetailsCubit(
      '556',
      artObjectsRepository,
      errorToMessageConverter,
    );
  });

  test('initial state is loading', () {
    expect(artObjectDetailsCubit.state, isA<ArtObjectDetailsLoadingState>());
  });

  blocTest(
    'an error occurs while loading',
    setUp: () {
      when(() => artObjectsRepository.getArtObjectDetails('556')).thenAnswer((_) {
        throw const SocketException('');
      });
    },
    build: () => artObjectDetailsCubit,
    act: (bloc) => bloc.fetchArtObjectDetails(),
    expect: () => [
      predicate<ArtObjectDetailsErrorState>((state) {
        return state.message == 'An error occurred';
      }),
    ],
    verify: (_) {
      verify(() => errorToMessageConverter.convert(const SocketException(''))).called(1);
    },
  );

  blocTest(
    'successfully loads',
    setUp: () {
      when(() => artObjectsRepository.getArtObjectDetails('556')).thenAnswer((_) async {
        return FakeArtObjectDetails();
      });
    },
    build: () => artObjectDetailsCubit,
    act: (bloc) => bloc.fetchArtObjectDetails(),
    expect: () => [
      isA<ArtObjectDetailsLoadedState>(),
    ],
  );
  blocTest<ArtObjectDetailsCubit, ArtObjectDetailsState>(
    'successfully loads after error',
    seed: () => ArtObjectDetailsErrorState('An error occurred'),
    setUp: () {
      when(() => artObjectsRepository.getArtObjectDetails('556')).thenAnswer((_) async {
        return FakeArtObjectDetails();
      });
    },
    build: () => artObjectDetailsCubit,
    act: (bloc) => bloc.fetchArtObjectDetails(),
    expect: () => [
      isA<ArtObjectDetailsLoadingState>(),
      isA<ArtObjectDetailsLoadedState>(),
    ],
  );
}
