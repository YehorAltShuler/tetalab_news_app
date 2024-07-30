import 'package:dio/dio.dart';

class Failure {
  final String message;

  Failure([this.message = 'An unexpected error occurred']);
}

class DataFailure implements Failure {
  final DioException error;

  DataFailure(this.error);

  @override
  String get message => error.toString();
}
