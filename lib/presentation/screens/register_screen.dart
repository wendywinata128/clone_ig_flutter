// ignore_for_file: prefer_const_constructors

import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_button.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_input.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_layout.dart';
import 'package:clone_ig_flutter/presentation/widgets/column_gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthProvider authProvider;
  late GlobalKey<FormBuilderState> formKey;

  onRegisterPressed() {
    authProvider.register(formKey, context);
  }

  @override
  void initState() {
    super.initState();
    authProvider = getProvider<AuthProvider>(context, false);
    formKey = GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: AppBar(),
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
                  Text(
                    "Create New Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  BaseInput(
                    name: "name",
                    title: "Name",
                  ),
                  BaseInput(
                    name: "username",
                    title: "Username",
                  ),
                  BaseInput(
                    name: "email",
                    title: "Email",
                  ),
                  BaseInput(
                    name: "password",
                    title: "Password",
                    isPassword: true,
                  ),
                  Consumer<AuthProvider>(
                    builder: (_, provider, __) => BaseButton(
                      title: "Register",
                      onPressed: onRegisterPressed,
                      isLoading: provider.isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
