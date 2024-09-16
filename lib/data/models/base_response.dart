import 'package:dio/dio.dart';

class BasicResponse<T> {
  final int status;
  final String message;
  final Response? response;
  T data;

  BasicResponse(
      {this.status = 200,
      required this.message,
      required this.data,
      this.response});
}
