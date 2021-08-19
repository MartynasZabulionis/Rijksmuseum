import 'package:flutter/material.dart';
import 'package:rijksmuseum/helpers/fetching_widget_state.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/screens/art_object_details_screen.dart';
import 'package:rijksmuseum/services/data_repository.dart';

class ArtObjectsScreen extends StatefulWidget {
  final DataRepository dataFetcher;
  const ArtObjectsScreen(this.dataFetcher);

  @override
  _ArtObjectsScreenState createState() => _ArtObjectsScreenState();
}

class _ArtObjectsScreenState extends FetchingWidgetState<ArtObjectsScreen> {
  late List<ArtObject> artObjects;

  @override
  Future<void> fetchData() async {
    artObjects = await widget.dataFetcher.fetchArtObjects(this);
  }

  void onArtObjectTapped(ArtObject item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ArtObjectDetailsScreen(
          artObject: item,
          dataRepository: widget.dataFetcher,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Art objects"),
      ),
      body: getWidgetByState(
        () => ListView.builder(
          itemCount: artObjects.length,
          physics: const RangeMaintainingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          itemBuilder: (context, i) {
            return Card(
              child: InkWell(
                onTap: () => onArtObjectTapped(artObjects[i]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: artObjects[i].headerImgUrl == null
                            ? null
                            : StatefulBuilder(
                                builder: (context, setState) {
                                  final imgProvider = NetworkImage(artObjects[i].headerImgUrl!);
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
                                            child: ColoredBox(
                                              color: Colors.black,
                                              child: Center(
                                                child: const Icon(
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
                      ),
                      const SizedBox(height: 10),
                      Text(
                        artObjects[i].principalOrFirstMaker,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.purple.shade300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        artObjects[i].title,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.purple.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
