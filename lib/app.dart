import 'package:blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum/injector.dart';

import 'screens/art_objects_screen/art_objects_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
      ),
      home: BlocProvider(
        create: (context) => injector<ArtObjectsCubit>()..fetchNewArtObjects(),
        child: const ArtObjectsScreen(),
      ),
    );
  }
}
