import 'package:clone_ig_flutter/core/utils/logger.dart';
import 'package:clone_ig_flutter/data/models/base_response.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/data/services/base_service.dart';
import 'package:dio/dio.dart';

class AuthService extends BaseService {
  static final AuthService _authService = AuthService._internal();

  AuthService._internal();

  static AuthService getInstance() {
    return _authService;
  }

  Future<BasicResponse> register(Map<String, dynamic> registerData) async {
    logger.info(registerData);
    var result = await basePost(
        url: "user/register", data: FormData.fromMap(registerData));

    return result;
  }

  Future<BasicResponse> login(Map<String, dynamic> registerData) async {
    var result = await basePost(url: "user/login", data: registerData);

    return result;
  }

  Future<BasicResponse<User?>> user() async {
    var result = await baseGet<User>(
      url: "user",
      mappedFunc: (user) => User.fromJson(user),
    );

    logger.info(result.data);

    return result;
  }
}
