import 'package:flutter/material.dart';
import 'package:rijksmuseum/screens/art_objects_screen.dart';
import 'package:rijksmuseum/services/data_repository.dart';

void main() {
  runApp(App(HttpDataFetcher()));
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
      home: ArtObjectsScreen(dataRepository),
    );
  }
}
