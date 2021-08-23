import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum/cubit/art_object/art_object_cubit.dart';
import 'package:rijksmuseum/screens/art_objects_screen/widgets/art_object_tile.dart';
import 'package:rijksmuseum/widgets/error_text_and_try_again_button.dart';
import 'package:rijksmuseum/widgets/fetching_progress_indicator.dart';

class ArtObjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArtObjectCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Art objects"),
      ),
      body: BlocBuilder<ArtObjectCubit, ArtObjectState>(
        builder: (context, state) {
          if (state is ArtObjectFetching) return FetchingProgressIndicator();
          if (state is ArtObjectError)
            return ErrorTextAndTryAgainButton(
              message: state.message,
              onPressed: bloc.fetchArtObjects,
            );

          state as ArtObjectSuccess;

          return ListView.builder(
            itemCount: state.artObjects.length,
            physics: const RangeMaintainingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            itemBuilder: (context, i) {
              return ArtObjectTile(state.artObjects[i]);
            },
          );
        },
      ),
    );
  }
}
