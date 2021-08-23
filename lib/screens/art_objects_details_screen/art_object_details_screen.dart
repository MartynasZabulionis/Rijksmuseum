import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum/cubit/art_object_details/art_object_details_cubit.dart';
import 'package:rijksmuseum/screens/art_objects_details_screen/widgets/art_object_picture.dart';
import 'package:rijksmuseum/widgets/error_text_and_try_again_button.dart';
import 'package:rijksmuseum/widgets/fetching_progress_indicator.dart';

class ArtObjectDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArtObjectDetailsCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.artObject.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArtObjectPicture(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                bloc.artObject.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Principal or first maker: ' + bloc.artObject.principalOrFirstMaker,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ArtObjectDetailsCubit, ArtObjectDetailsState>(
              builder: (context, state) {
                if (state is ArtObjectDetailsFetching) return FetchingProgressIndicator();
                if (state is ArtObjectDetailsError)
                  return ErrorTextAndTryAgainButton(
                    message: state.message,
                    onPressed: bloc.fetchArtObjectDetails,
                  );

                state as ArtObjectDetailsSuccess;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Materials: ' + state.artObjectDetails.materials.join(', '),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 20),
                      Text(state.artObjectDetails.plaqueDescriptionEnglish),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
