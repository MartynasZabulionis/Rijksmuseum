import 'package:flutter/material.dart';

import 'app.dart';
import 'injector.dart';

void main() async {
  registerDependencies();
  runApp(const App());
}
