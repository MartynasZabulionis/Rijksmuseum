import 'package:dio/dio.dart';
import 'package:models/models.dart';

mixin ApiCallMixin {
  Future<T> apiCallWrapper<T>(Future<T> Function() callback) async {
    try {
      return await callback();
    } catch (e) {
      if (e is DioError) {
        if (e.error != null) {
          throw Failure(error: e.error);
        } else {
          throw Failure(error: e.message);
        }
      }
      throw Failure(error: e);
    }
  }
}
