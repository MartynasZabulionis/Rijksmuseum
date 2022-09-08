import 'dart:collection';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:blocs/art_objects_cubit.dart';
import 'package:blocs/converters/loading_error_to_message_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repositories/repositories.dart';

import 'fakes.dart';
import 'mocks.dart';

void main() {
  late ArtObjectsCubit artObjectsCubit;
  late ArtObjectsRepository artObjectsRepository;
  late LoadingErrorToMessageConverter errorToMessageConverter;

  setUp(() {
    artObjectsRepository = ArtObjectsRepositoryMock();
    errorToMessageConverter = LoadingErrorToMessageConverterMock();

    artObjectsCubit = ArtObjectsCubit(artObjectsRepository, errorToMessageConverter);
  });

  test('initial state is ArtObjectsInitialLoadingState', () {
    expect(artObjectsCubit.state, isA<ArtObjectsInitialLoadingState>());
  });
  group('initial load:', () {
    blocTest(
      'returns empty list',
      setUp: () {
        when(() => artObjectsRepository.getArtObjects(1)).thenAnswer((_) {
          return Future.value([]);
        });
      },
      build: () => artObjectsCubit,
      act: (b) => b.fetchNewArtObjects(),
      expect: () => [
        predicate<ArtObjectsLoadedState>((state) {
          return state.artObjects.isEmpty &&
              !state.isLoadingMore &&
              state.loadingMoreErrorMessage.isEmpty;
        }),
      ],
    );
    blocTest(
      'returns error',
      setUp: () {
        when(() => artObjectsRepository.getArtObjects(1)).thenAnswer((_) {
          throw const SocketException('');
        });
      },
      build: () => artObjectsCubit,
      act: (b) => b.fetchNewArtObjects(),
      expect: () => [
        predicate<ArtObjectsInitialLoadingErrorState>((state) {
          return state.message == 'An error occurred';
        }),
      ],
      verify: (_) {
        verify(() => errorToMessageConverter.convert(const SocketException(''))).called(1);
      },
    );
    blocTest<ArtObjectsCubit, ArtObjectsState>(
      'returns empty list after failed first load',
      seed: () => const ArtObjectsInitialLoadingErrorState(''),
      setUp: () {
        when(() => artObjectsRepository.getArtObjects(1)).thenAnswer((_) {
          return Future.value([]);
        });
      },
      build: () => artObjectsCubit,
      act: (b) => b.fetchNewArtObjects(),
      expect: () => [
        isA<ArtObjectsInitialLoadingState>(),
        predicate<ArtObjectsLoadedState>((state) {
          return state.artObjects.isEmpty &&
              !state.isLoadingMore &&
              state.loadingMoreErrorMessage.isEmpty;
        }),
      ],
    );
  });

  group('loading more:', () {
    blocTest(
      'returns list',
      setUp: () {
        when(() => artObjectsRepository.getArtObjects(any())).thenAnswer((_) {
          return Future.value([FakeArtObject(), FakeArtObject()]);
        });
      },
      build: () => artObjectsCubit,
      act: (b) async {
        b.fetchNewArtObjects();
        await b.stream.firstWhere((e) => e is ArtObjectsLoadedState);
        b.fetchNewArtObjects();
      },
      expect: () => [
        predicate<ArtObjectsLoadedState>((state) {
          return !state.isLoadingMore && state.loadingMoreErrorMessage.isEmpty;
        }),
        predicate<ArtObjectsLoadedState>((state) {
          // return true;
          return state.isLoadingMore && state.loadingMoreErrorMessage.isEmpty;
        }),
        predicate<ArtObjectsLoadedState>((state) {
          // return true;
          return state.artObjects.length == 4 &&
              !state.isLoadingMore &&
              state.loadingMoreErrorMessage.isEmpty;
        }),
      ],
    );
    blocTest(
      'returns error',
      setUp: () {
        when(() => artObjectsRepository.getArtObjects(1)).thenAnswer((_) {
          return Future.value([FakeArtObject(), FakeArtObject()]);
        });
        when(() => artObjectsRepository.getArtObjects(2)).thenAnswer((_) {
          throw const SocketException('');
        });
      },
      build: () => artObjectsCubit,
      act: (b) async {
        b.fetchNewArtObjects();
        await b.stream.firstWhere((e) => e is ArtObjectsLoadedState);
        b.fetchNewArtObjects();
      },
      expect: () => [
        predicate<ArtObjectsLoadedState>((state) {
          return state.artObjects.length == 2 &&
              !state.isLoadingMore &&
              state.loadingMoreErrorMessage.isEmpty;
        }),
        predicate<ArtObjectsLoadedState>((state) {
          return state.artObjects.length == 2 &&
              state.isLoadingMore &&
              state.loadingMoreErrorMessage.isEmpty;
        }),
        predicate<ArtObjectsLoadedState>((state) {
          return state.artObjects.length == 2 &&
              !state.isLoadingMore &&
              state.loadingMoreErrorMessage.isNotEmpty;
        }),
      ],
    );
    blocTest<ArtObjectsCubit, ArtObjectsState>(
      'returns list after error',
      setUp: () {
        when(() => artObjectsRepository.getArtObjects(any())).thenAnswer((_) {
          return Future.value([FakeArtObject(), FakeArtObject(), FakeArtObject()]);
        });
      },
      build: () => artObjectsCubit,
      seed: () => ArtObjectsLoadedState(
        artObjects: UnmodifiableListView([FakeArtObject(), FakeArtObject()]),
        isLoadingMore: false,
        loadingMoreErrorMessage: 'An error occurred',
      ),
      act: (b) async {
        b.fetchNewArtObjects();
      },
      expect: () => [
        predicate<ArtObjectsLoadedState>((state) {
          return state.isLoadingMore && state.loadingMoreErrorMessage.isEmpty;
        }),
        predicate<ArtObjectsLoadedState>((state) {
          return state.artObjects.length == 3 &&
              !state.isLoadingMore &&
              state.loadingMoreErrorMessage.isEmpty;
        }),
      ],
    );
  });
}
