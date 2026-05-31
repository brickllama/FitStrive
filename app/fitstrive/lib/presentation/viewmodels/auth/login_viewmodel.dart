import 'dart:developer';
import 'dart:math';
import 'package:fitstrive/application/usecases/login_usecase.dart';

import '../base_viewmodel.dart';
import '../../models/auth/auth_form_models.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/password.dart';
import 'package:flutter/material.dart';

// ViewModel responsible for handling the login screen logic

class LoginViewModel extends BaseViewModel {
  final LoginUseCase _loginUseCase;

  LoginViewModel({required final LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase;

  // LoginViewModel({required this.loginUseCase});

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

  // login actions
  // attempts to authenticate user
  Future<bool> login() async {
    // stop if form is invalid
    //if (!formKey.currentState!.validate()) return false;

    // inherited from BaseViewModel
    return runAsync(() async {
      var email = Email(value: _form.email);
      var password = Password(value: _form.password);
      final result = await _loginUseCase.execute(
        email: email,
        password: password,
      );
      print('worked? ${result is Ok}');
      // TODO: proceed?
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
