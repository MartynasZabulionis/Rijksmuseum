import 'dart:convert';
import 'dart:io';

import 'package:models/models.dart';

class LoadingErrorToMessageConverter extends Converter<Object, String> {
  @override
  String convert(Object input) {
    if (input is Failure) {
      input = input.error;
    }
    if (input is SocketException) {
      return 'Could not connect to the server';
    }
    return 'An unexpected error occured while loading';
  }
}
