import 'dart:developer';

import 'package:fitstrive/application/usecases/register_usecase.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:flutter/material.dart';
import '../base_viewmodel.dart';
import '../../models/auth/auth_form_models.dart';
import '../../models/auth/auth_validators.dart';

// ViewModel responsible for hanlding the login screen state
// TODO: import from application layer once available

class RegisterViewModel extends BaseViewModel {
  RegisterUseCase registerUseCase;

  RegisterViewModel({required this.registerUseCase});
  // form controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // UI state
  // determined wether password field is hidden or visable
  // true = password is hidden
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirm => _obscureConfirm;

  // internal immutable form model containing current register input values
  RegisterFormModel _form = const RegisterFormModel();
  RegisterFormModel get form => _form;

  // toggles password visibilty in the password text field
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    // triggers UI rebuild so the view updates
    notifyListeners();
  }

  // same for confirm password
  void toggleConfirmVisibility() {
    _obscureConfirm = !_obscureConfirm;
    notifyListeners();
  }

  // updates the values for username, email, pass, confirm pass inside the immutable form model
  void onUsernameChanged(String value) =>
      _form = _form.copyWith(username: value);
  void onEmailChanged(String value) => _form = _form.copyWith(email: value);
  void onPasswordChanged(String value) =>
      _form = _form.copyWith(password: value);
  void onConfirmPasswordChanged(String value) =>
      _form = _form.copyWith(confirmPassword: value);

  // email, user, pass validation straight from shared validators
  // register uses strongPassword, not basic password
  String? validateUsername(String? value) => AuthValidators.username(value);
  String? validateEmail(String? value) => AuthValidators.email(value);
  String? validatePassword(String? value) =>
      AuthValidators.strongPassword(value);
  String? validateConfirmPassword(String? value) =>
      AuthValidators.confirmPassword(passwordController.text)(value);

  // login actions
  // attempts to authenticate user
  Future<bool> register() async {
    // stop in form is invalid
    if (!formKey.currentState!.validate()) return false;

    return runAsync(() async {
      log("Register Attempt");
      final result = await registerUseCase.execute(
        email: _form.email,
        password: _form.password,
      );
      if (result is Ok) {
      } else {}
      // TODO: use application layer use case
      //
      // will probably use something like:
      // final result = await _registerUseCase(
      //   RegisterParams(
      //     username: _form.username,
      //     email: _form.email,
      //     password: _form.password,
      //   ),
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
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
