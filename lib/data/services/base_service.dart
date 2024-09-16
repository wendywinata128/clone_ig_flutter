import 'package:clone_ig_flutter/core/constants/url.dart';
import 'package:clone_ig_flutter/core/utils/logger.dart';
import 'package:clone_ig_flutter/core/utils/toast.dart';
import 'package:clone_ig_flutter/core/utils/token_manager.dart';
import 'package:clone_ig_flutter/data/models/base_response.dart';
import 'package:dio/dio.dart';

class BaseService {
  final baseURL = ConstantURL.BASE_URL;
  final dioClient = Dio(BaseOptions(baseUrl: ConstantURL.BASE_URL));

  Future<BasicResponse<T?>> basePost<T>(
      {required String url,
      dynamic data = const {},
      T Function(dynamic)? mappedFunc}) async {
    try {
      logger.info("Post Request Started - $url");
      var result = await dioClient.post(
        "$baseURL/$url",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${TokenManager.getToken()}",
          },
        ),
      );
      handleSuccess(result);

      return BasicResponse(
          message: "Success",
          data: mappedFunc != null
              ? mappedFunc(result.data['data'])
              : result.data?['data'],
          response: result);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<BasicResponse<T?>> baseGet<T>(
      {required String url, T Function(dynamic)? mappedFunc}) async {
    try {
      logger.info("Get Request Started - $url");
      var result = await dioClient.get(
        "$baseURL/$url",
        options: Options(
          headers: {
            "Authorization": "Bearer ${TokenManager.getToken()}",
          },
        ),
      );
      handleSuccess(result);

      return BasicResponse(
        message: "Success",
        data: mappedFunc != null
            ? mappedFunc(result.data['data'])
            : result.data['data'],
        response: result,
      );
    } catch (e) {
      return handleError(e);
    }
  }

  Future<BasicResponse<T?>> basePatch<T>(
      {required String url,
      Map<String, dynamic> data = const {},
      T Function(dynamic)? mappedFunc}) async {
    try {
      logger.info("Patch Request Started - $url");
      var result = await dioClient.patch(
        "$baseURL/$url",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${TokenManager.getToken()}",
          },
        ),
      );
      handleSuccess(result);

      return BasicResponse(
          message: "Success",
          data: mappedFunc != null
              ? mappedFunc(result.data['data'])
              : result.data?['data'],
          response: result);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<BasicResponse<T?>> baseDelete<T>({required String url}) async {
    try {
      logger.info("Delete Request Started - $url");
      var result = await dioClient.delete(
        "$baseURL/$url",
        options: Options(
          headers: {
            "Authorization": "Bearer ${TokenManager.getToken()}",
          },
        ),
      );
      handleSuccess(result);

      return BasicResponse(message: "Success", data: null, response: result);
    } catch (e) {
      return handleError(e);
    }
  }

  BasicResponse<Null> handleError(dynamic e) {
    logger.warning(e);

    if (e is DioException) {
      final data = e.response?.data;

      if (data != null) {
        showToastMessage(data['message'], type: ToastType.FAILED);
        return BasicResponse(message: data['message'], data: null, status: 400);
      }
    }

    showToastMessage("Internal Server Error", type: ToastType.FAILED);
    return BasicResponse(message: "Unknown Error", data: null, status: 400);
  }

  void handleSuccess(Response result) {
    logger.info("Post Request Completed");
    logger.info("Status : ${result.statusCode}");
    logger.info("Status : ${result.data}");
  }
}
