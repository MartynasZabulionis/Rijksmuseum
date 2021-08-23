import 'package:flutter/material.dart';
import 'package:rijksmuseum/models/art_object.dart';

class ArtObjectHeaderPicture extends StatelessWidget {
  final ArtObject artObject;
  const ArtObjectHeaderPicture(this.artObject);

  @override
  Widget build(BuildContext context) {
    final imgProvider = artObject.headerImgUrl == null ? null : NetworkImage(artObject.headerImgUrl!);
    return SizedBox(
      width: double.infinity,
      child: imgProvider == null
          ? null
          : StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  height: 90,
                  child: ColoredBox(
                    color: Colors.white,
                    child: Image(
                      image: imgProvider,
                      key: UniqueKey(),
                      errorBuilder: (_, __, ___) {
                        return GestureDetector(
                          onTap: () {
                            imgProvider.evict();
                            setState(() {});
                          },
                          child: const ColoredBox(
                            color: Colors.black,
                            child: Center(
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (_, widget, progress) {
                        if (progress == null) return widget;
                        return const ColoredBox(
                          color: Colors.black,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
