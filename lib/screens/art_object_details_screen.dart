import 'package:flutter/material.dart';
import 'package:rijksmuseum/helpers/fetching_widget_state.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/models/art_object_details.dart';
import 'package:rijksmuseum/services/data_repository.dart';

class ArtObjectDetailsScreen extends StatefulWidget {
  final ArtObject artObject;
  final DataRepository dataRepository;

  const ArtObjectDetailsScreen({
    required this.artObject,
    required this.dataRepository,
  });

  @override
  _ArtObjectDetailsScreenState createState() => _ArtObjectDetailsScreenState();
}

class _ArtObjectDetailsScreenState extends FetchingWidgetState<ArtObjectDetailsScreen> {
  late ArtObjectDetails artObjectDetails;

  ImageProvider? imgProvider;
  var imageKey = UniqueKey();

  @override
  void initState() {
    if (widget.artObject.webImgUrl != null)
      imgProvider = ResizeImage(
        NetworkImage(widget.artObject.webImgUrl!),
        width: 500,
      );
    super.initState();
  }

  @override
  Future<void> fetchData() async {
    imgProvider?.evict();
    imageKey = UniqueKey();
    artObjectDetails = await widget.dataRepository.fetchArtObjectDetails(this, widget.artObject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artObject.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: ColoredBox(
                color: Colors.black,
                child: imgProvider == null
                    ? null
                    : Image(
                        key: imageKey,
                        image: imgProvider!,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.artObject.title,
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
                'Principal or first maker: ' + widget.artObject.principalOrFirstMaker,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            getWidgetByState(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Materials: ' + artObjectDetails.materials.join(', '),
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 20),
                    Text(artObjectDetails.plaqueDescriptionEnglish),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
