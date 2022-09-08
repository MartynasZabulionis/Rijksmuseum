import 'package:flutter/material.dart';

class ArtObjectPicture extends StatelessWidget {
  final String? imgUrl;

  const ArtObjectPicture({super.key, required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    final imgUrl = this.imgUrl;

    var imgKey = UniqueKey();

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: ColoredBox(
        color: Colors.black,
        child: imgUrl == null
            ? null
            : Image(
                key: imgKey,
                image: ResizeImage(
                  NetworkImage(imgUrl),
                  width: 500,
                ),
                errorBuilder: (_, __, ___) => const Placeholder(),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                },
              ),
        // BlocBuilder<ArtObjectDetailsCubit, ArtObjectDetailsState>(
        //     builder: (context, state) {
        //       if (state is ArtObjectDetailsLoadingState) {
        //         imgKey = UniqueKey();
        //         imgProvider.evict();
        //       }
        //       return Image(
        //         key: imgKey,
        //         image: imgProvider,
        //         errorBuilder: (_, __, ___) => const Placeholder(),
        //         loadingBuilder: (_, child, progress) {
        //           if (progress == null) return child;
        //           return const Center(
        //             child: CircularProgressIndicator(
        //               valueColor: AlwaysStoppedAnimation(Colors.white),
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
      ),
    );
  }
}
