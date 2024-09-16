// ignore_for_file: prefer_const_constructors

import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/screens/register_screen.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_button.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_input.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_layout.dart';
import 'package:clone_ig_flutter/presentation/widgets/column_gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = getProvider<AuthProvider>(context, false);
    authProvider.initialCheck(context);
  }

  void onCreateButtonPressed() {
    navigateToWidget(context, RegisterScreen());
  }

  void onLoginButtonPressed() {
    authProvider.login(formKey, context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ColumnGap(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                gap: 16,
                children: [
                  Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 82,
                      color: Color.fromRGBO(221, 42, 123, 1),
                    ),
                  ),
                  BaseInput(
                    name: "username",
                    title: "Username",
                  ),
                  BaseInput(
                    name: "password",
                    title: "Password",
                    isPassword: true,
                    onSubmitted: (val) => onLoginButtonPressed(),
                  ),
                  Consumer<AuthProvider>(
                    builder: (_, provider, __) => BaseButton(
                      title: "Log in",
                      onPressed: onLoginButtonPressed,
                      isLoading: provider.isLoading,
                    ),
                  ),
                  BaseButton(
                    title: "Forgot Password?",
                    type: ButtonType.TEXT,
                  ),
                ],
              ),
            ),
            BaseButton(
              title: "Create new account",
              type: ButtonType.OUTLINED,
              onPressed: onCreateButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}
