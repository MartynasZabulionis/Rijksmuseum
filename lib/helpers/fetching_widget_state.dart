import 'dart:io';

import 'package:flutter/material.dart';

enum FetchingState {
  fetching,
  fetched,
  error,
}

abstract class FetchingWidgetState<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
    startFetchingData();
  }

  String? errorMessage;

  var fetchingState = FetchingState.fetching;
  Future<void> fetchData();

  void startFetchingData() async {
    fetchingState = FetchingState.fetching;
    if (mounted) setState(() {});
    try {
      await fetchData();
    } catch (e) {
      if (e is SocketException)
        errorMessage = 'No internet connection';
      else
        errorMessage = 'An error occurred';

      fetchingState = FetchingState.error;
      if (mounted) setState(() {});
      return;
    }
    errorMessage = null;
    fetchingState = FetchingState.fetched;
    if (mounted) setState(() {});
  }

  Widget getWidgetByState(Widget Function() fetchedStateBuilder) {
    if (fetchingState == FetchingState.fetching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (fetchingState == FetchingState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage!,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: startFetchingData,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      );
    }
    return fetchedStateBuilder();
  }
}
