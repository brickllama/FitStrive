import 'dart:developer';

import 'package:fitstrive/application/usecases/login_usecase.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:flutter/material.dart';
import '../base_viewmodel.dart';
import '../../models/auth/auth_form_models.dart';
import '../../models/auth/auth_validators.dart';

// ViewModel responsible for handling the login screen logic
// TODO: import from application layer once available

class LoginViewModel extends BaseViewModel {
  final LoginUseCase loginUseCase;

  LoginViewModel({required this.loginUseCase});
  // form controllers, owned by the ViewModel, not the View
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // UI state
  // determined wether password field is hidden or visable
  // true = password is hidden
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  // internal immutable form model containing current login input values
  LoginFormModel _form = const LoginFormModel();
  LoginFormModel get form => _form;

  // toggles password visibilty in the password text field
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    // triggers UI rebuild so the view updates
    notifyListeners();
  }

  // updates the email value inside the immutable form model
  // called whenever a user types into the email field
  void onEmailChanged(String value) {
    _form = _form.copyWith(email: value);
    // No notifyListeners needed b/c rebuilding on every keystroke is unnecessary
  }

  // updates the password value inside the immutable form model
  void onPasswordChanged(String value) {
    _form = _form.copyWith(password: value);
  }

  // email and pass validation straight to shared validators
  String? validateEmail(String? value) => AuthValidators.email(value);
  String? validatePassword(String? value) => AuthValidators.password(value);

  // login actions
  // attempts to authenticate user
  Future<bool> login() async {
    // stop if form is invalid
    if (!formKey.currentState!.validate()) return false;

    // inherited from BaseViewModel
    return runAsync(() async {
      log("Login Attempt");
      final result = await loginUseCase.execute(
        email: _form.email,
        password: _form.password,
      );
      if (result is Ok) {
      } else {}
      // TODO: use application layer use case
      //
      // will probably use something like:
      // final result = await _loginUseCase(
      //   LoginParams(email: _form.email, password: _form.password),
      // );
      // result.fold(
      //   (failure) => throw Exception(failure.message),
      //   (_) => null,
      // );

      // placeholder delay until application layer is connected
      //await Future.delayed(const Duration(seconds: 1));
    });
  }

  // dispose controllers to prevent memory leaks
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
