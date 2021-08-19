class ArtObject {
  final String title;
  final String? headerImgUrl;
  final String? webImgUrl;
  final String objectNumber;
  final String principalOrFirstMaker;

  ArtObject({
    required this.principalOrFirstMaker,
    required this.webImgUrl,
    required this.title,
    required this.headerImgUrl,
    required this.objectNumber,
  });
}
