import 'package:flutter/material.dart';

class ErrorTextAndTryAgainButton extends StatelessWidget {
  final String message;
  final void Function() onPressed;
  const ErrorTextAndTryAgainButton({
    Key? key,
    required this.message,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.refresh),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
