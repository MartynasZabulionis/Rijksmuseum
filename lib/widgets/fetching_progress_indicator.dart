import 'package:flutter/material.dart';

class FetchingProgressIndicator extends StatelessWidget {
  const FetchingProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
