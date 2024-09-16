import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/core/utils/toast.dart';
import 'package:clone_ig_flutter/core/utils/token_manager.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/data/services/auth_service.dart';
import 'package:clone_ig_flutter/presentation/screens/home_screen.dart';
import 'package:clone_ig_flutter/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User? userData;
  var isLoggedIn = false;
  var isLoading = false;

  final _authService = AuthService.getInstance();

  initialCheck(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString("token");

    if (token != null) {
      fetchUser(token, context);
    }
  }

  register(GlobalKey<FormBuilderState> formKey, BuildContext context) async {
    final state = formKey.currentState;
    isLoading = true;
    notifyListeners();

    if (state == null || !state.validate()) {
      return;
    }

    state.save();

    final result = await _authService.register(state.value);

    if (result.status == 200) {
      showToastMessage("Register Success");
      navigateReplacementAllToWidget(context, const LoginScreen());
    }

    isLoading = false;
    notifyListeners();
  }

  login(GlobalKey<FormBuilderState> formKey, BuildContext context) async {
    final state = formKey.currentState;
    isLoading = true;
    notifyListeners();

    if (state == null || !state.validate()) {
      return;
    }

    state.save();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final result = await _authService.login(state.value);

    if (result.status == 200) {
      final token = result.data;

      if (token != null) {
        sharedPreferences.setString("token", token);
        fetchUser(token, context);
      }
    } else {
      sharedPreferences.remove("token");
    }

    isLoading = false;
    notifyListeners();
  }

  logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove("token");
    TokenManager.removeToken();
    navigateReplacementAllToWidget(context, const LoginScreen());
  }

  fetchUser(String token, BuildContext context) async {
    TokenManager.saveToken(token);

    final resultUser = await _authService.user();
    if (resultUser.status == 200) {
      isLoggedIn = true;
      userData = resultUser.data;
      navigateReplacementToWidget(context, const HomeScreen());
      showToastMessage("Login Success");
    }
  }
}
