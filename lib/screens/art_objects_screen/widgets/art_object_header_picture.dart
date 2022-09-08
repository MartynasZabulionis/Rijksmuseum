import 'package:flutter/material.dart';

class ArtObjectHeaderPicture extends StatelessWidget {
  final String? imgUrl;
  const ArtObjectHeaderPicture(this.imgUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final imgUrl = this.imgUrl;
    return SizedBox(
      width: double.infinity,
      child: imgUrl == null
          ? null
          : SizedBox(
              height: 90,
              child: ColoredBox(
                color: Colors.white,
                child: _ArtObjectHeaderPicture(imgUrl: imgUrl),
              ),
            ),
    );
  }
}

class _ArtObjectHeaderPicture extends StatefulWidget {
  final String imgUrl;
  const _ArtObjectHeaderPicture({required this.imgUrl});

  @override
  State<_ArtObjectHeaderPicture> createState() => __ArtObjectHeaderPictureState();
}

class __ArtObjectHeaderPictureState extends State<_ArtObjectHeaderPicture> {
  var _imageKey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(widget.imgUrl),
      key: _imageKey,
      errorBuilder: (_, __, ___) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _imageKey = UniqueKey();
            });
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
    );
  }
}
