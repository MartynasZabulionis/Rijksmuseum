import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum/cubit/art_object/art_object_cubit.dart';
import 'package:rijksmuseum/cubit/art_object_details/art_object_details_cubit.dart';
import 'package:rijksmuseum/models/art_object.dart';
import 'package:rijksmuseum/screens/art_objects_details_screen/art_object_details_screen.dart';
import 'package:rijksmuseum/screens/art_objects_screen/widgets/art_object_header_picture.dart';

class ArtObjectTile extends StatelessWidget {
  final ArtObject artObject;
  const ArtObjectTile(this.artObject);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArtObjectCubit>(context);

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ArtObjectDetailsCubit(bloc.dataRepository, artObject)..fetchArtObjectDetails(),
                child: ArtObjectDetailsScreen(),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArtObjectHeaderPicture(artObject),
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
