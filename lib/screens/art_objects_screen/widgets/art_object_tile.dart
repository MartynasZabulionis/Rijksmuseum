import 'package:blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:rijksmuseum/injector.dart';
import 'package:rijksmuseum/screens/art_objects_details_screen/art_object_details_screen.dart';
import 'package:rijksmuseum/screens/art_objects_screen/widgets/art_object_header_picture.dart';

class ArtObjectTile extends StatelessWidget {
  final ArtObject artObject;
  const ArtObjectTile(this.artObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) {
                  return injector.get<ArtObjectDetailsCubit>(param1: artObject.objectNumber)
                    ..fetchArtObjectDetails();
                },
                child: const ArtObjectDetailsScreen(),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArtObjectHeaderPicture(artObject.headerImage?.url),
              const SizedBox(height: 10),
              Text(
                artObject.principalOrFirstMaker,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.purple.shade300,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                artObject.title,
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
  }
}
