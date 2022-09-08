import 'package:blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum/screens/art_objects_details_screen/widgets/art_object_picture.dart';
import 'package:rijksmuseum/widgets/error_text_and_try_again_button.dart';
import 'package:rijksmuseum/widgets/fetching_progress_indicator.dart';

class ArtObjectDetailsScreen extends StatelessWidget {
  const ArtObjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ArtObjectDetailsCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ArtObjectDetailsCubit, ArtObjectDetailsState>(
          builder: (context, state) {
            if (state is ArtObjectDetailsLoadedState) {
              return Text(
                state.artObjectDetails.title,
                maxLines: 3,
              );
            }
            return const SizedBox();
          },
        ),
      ),
      body: BlocBuilder<ArtObjectDetailsCubit, ArtObjectDetailsState>(
        builder: (context, state) {
          if (state is ArtObjectDetailsErrorState) {
            return ErrorTextAndTryAgainButton(
              message: state.message,
              onPressed: cubit.fetchArtObjectDetails,
            );
          }
          if (state is ArtObjectDetailsLoadedState) {
            return _ArtObjectDetailsLoadedContent(state);
          }
          return const FetchingProgressIndicator();
        },
      ),
    );
  }
}

class _ArtObjectDetailsLoadedContent extends StatelessWidget {
  final ArtObjectDetailsLoadedState state;
  const _ArtObjectDetailsLoadedContent(this.state);

  @override
  Widget build(BuildContext context) {
    final plaqueDescriptionEnglish = state.artObjectDetails.plaqueDescriptionEnglish;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArtObjectPicture(imgUrl: state.artObjectDetails.webImage?.url),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              state.artObjectDetails.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Principal or first maker: ${state.artObjectDetails.principalOrFirstMaker}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Materials: ${state.artObjectDetails.materials.join(', ')}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),
                if (plaqueDescriptionEnglish != null) Text(plaqueDescriptionEnglish),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
