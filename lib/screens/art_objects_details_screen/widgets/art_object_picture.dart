import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum/cubit/art_object_details/art_object_details_cubit.dart';

class ArtObjectPicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArtObjectDetailsCubit>(context);

    final img = bloc.artObject.webImgUrl;
    var imgProvider = img == null
        ? null
        : ResizeImage(
            NetworkImage(img),
            width: 500,
          );

    var imgKey = UniqueKey();

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: ColoredBox(
        color: Colors.black,
        child: imgProvider == null
            ? null
            : BlocBuilder<ArtObjectDetailsCubit, ArtObjectDetailsState>(
                builder: (context, state) {
                  if (state is ArtObjectDetailsFetching) {
                    imgKey = UniqueKey();
                    imgProvider.evict();
                  }
                  return Image(
                    key: imgKey,
                    image: imgProvider,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
