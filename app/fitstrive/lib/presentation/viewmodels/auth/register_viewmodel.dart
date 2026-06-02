import 'dart:developer';

import 'package:fitstrive/application/usecases/register_usecase.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:flutter/material.dart';
import '../base_viewmodel.dart';
import '../../models/auth/auth_form_models.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/username.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

// ViewModel responsible for hanlding the login screen state

class RegisterViewModel extends BaseViewModel {
  final RegisterUseCase _registrationUseCase;
  bool _registerSuccess = false;

  RegisterViewModel({required final RegisterUseCase registrationUseCase})
    : _registrationUseCase = registrationUseCase;

  // form controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
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
  void onFirstNameChanged(String value) =>
      _form = _form.copyWith(firstName: value);
  void onLastNameChanged(String value) =>
      _form = _form.copyWith(lastName: value);
  void onUsernameChanged(String value) =>
      _form = _form.copyWith(username: value);
  void onEmailChanged(String value) => _form = _form.copyWith(email: value);
  void onPasswordChanged(String value) =>
      _form = _form.copyWith(password: value);
  void onConfirmPasswordChanged(String value) =>
      _form = _form.copyWith(confirmPassword: value);

  // login actions
  // attempts to authenticate user
  Future<bool> register() async {
    // stop in form is invalid
    //if (!formKey.currentState!.validate()) return false;
    log("Register in ViewmOdel");
    return runAsync(() async {
      log("Register in ViewmOdel 2");
      try {
        log("pass" + _form.password);
        var email = Email(value: _form.email);
        var username = Username(value: _form.username);
        var name = Name(firstName: _form.firstName, lastName: _form.lastName);
        var password = Password(value: _form.password);

        final result = await _registrationUseCase.execute(
          email: email,
          username: username,
          name: name,
          password: password,
        );
        if (result != null) {
          notifyListeners();
        }
        return true;
      } catch (e) {
        log("error Register in ViewmOdel 2");
        log(e.toString());
        return false;
      }
    });
  }

  // dispose controllers to prevent memory leaks
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
