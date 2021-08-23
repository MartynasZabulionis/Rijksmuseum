import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:rijksmuseum/cubit/art_object/art_object_cubit.dart';
import 'package:rijksmuseum/screens/art_objects_screen/art_objects_screen.dart';
import 'package:rijksmuseum/services/data_repository.dart';

void main() {
  runApp(App(HttpDataFetcher(Client())));
}

class App extends StatelessWidget {
  final DataRepository dataRepository;
  App(this.dataRepository);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
      ),
      home: BlocProvider(
        create: (context) => ArtObjectCubit(dataRepository)..fetchArtObjects(),
        child: ArtObjectsScreen(),
      ),
    );
  }
}
