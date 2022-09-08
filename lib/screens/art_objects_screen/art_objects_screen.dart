import 'dart:developer';

import 'package:blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum/screens/art_objects_screen/widgets/art_object_tile.dart';
import 'package:rijksmuseum/widgets/error_text_and_try_again_button.dart';
import 'package:rijksmuseum/widgets/fetching_progress_indicator.dart';

class ArtObjectsScreen extends StatelessWidget {
  const ArtObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ArtObjectsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art objects'),
      ),
      body: BlocBuilder<ArtObjectsCubit, ArtObjectsState>(
        buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        bloc: cubit,
        builder: (context, state) {
          log(state.runtimeType.toString());
          if (state is ArtObjectsInitialLoadingErrorState) {
            return ErrorTextAndTryAgainButton(
              message: state.message,
              onPressed: cubit.fetchNewArtObjects,
            );
          }

          if (state is ArtObjectsLoadedState) {
            return const _ArtObjectsLoadedContent();
          }

          return const FetchingProgressIndicator();
        },
      ),
    );
  }
}

class _ArtObjectsLoadedContent extends StatefulWidget {
  const _ArtObjectsLoadedContent();

  @override
  State<_ArtObjectsLoadedContent> createState() => _ArtObjectsLoadedContentState();
}

class _ArtObjectsLoadedContentState extends State<_ArtObjectsLoadedContent> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_isLoading) {
      return;
    }
    final cubit = context.read<ArtObjectsCubit>();
    final cubitState = cubit.state as ArtObjectsLoadedState;
    if (cubitState.isLoadingMore || cubitState.loadingMoreErrorMessage.isNotEmpty) {
      return;
    }

    final nextPageTrigger = 0.9 * _scrollController.position.maxScrollExtent;

    if (_scrollController.position.pixels > nextPageTrigger) {
      _isLoading = true;
      cubit.fetchNewArtObjects();
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ArtObjectsCubit>(context);
    return BlocBuilder<ArtObjectsCubit, ArtObjectsState>(
      bloc: cubit,
      builder: (context, state) {
        state as ArtObjectsLoadedState;
        _isLoading = state.isLoadingMore;

        return ListView.builder(
          controller: _scrollController,
          itemCount: state.artObjects.length + 1,
          physics: const RangeMaintainingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          itemBuilder: (context, i) {
            if (i == state.artObjects.length) {
              if (state.loadingMoreErrorMessage.isNotEmpty) {
                return ErrorTextAndTryAgainButton(
                  message: state.loadingMoreErrorMessage,
                  onPressed: cubit.fetchNewArtObjects,
                );
              }
              return const FetchingProgressIndicator();
            }
            return ArtObjectTile(state.artObjects[i]);
          },
        );
      },
    );
  }
}
