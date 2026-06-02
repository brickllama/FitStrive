import 'package:flutter/material.dart';
import '../base_viewmodel.dart';
import '../../models/auth/auth_form_models.dart';
import '../../models/auth/auth_validators.dart';

// ViewModel responsible for the forgot password flow.
// TODO: import from application layer once available.

class ForgotPasswordViewModel extends BaseViewModel {
  // controller used to read/write the email TextField value
  final TextEditingController emailController = TextEditingController();
  // global form key used for validating the Flutter Form Widget
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // internal immutable form model containing current form values
  ForgotPasswordFormModel _form = const ForgotPasswordFormModel();
  // public read-only access to the current form state
  ForgotPasswordFormModel get form => _form;

  // True after a successful submission
  // View uses this to show the confirmation message instead of the form.
  bool _emailSent = false;
  bool get emailSent => _emailSent;

  // updates the email field inside the immutable form model
  // called whenever the user types into the email field
  void onEmailChanged(String value) => _form = _form.copyWith(email: value);

  // validates the email input field straight from shared validators
  String? validateEmail(String? value) => AuthValidators.email(value);

  // password reset logic:
  // attempts to send a password reset email
  Future<bool> sendResetEmail() async {
    // stop if the form is invalid
    if (!formKey.currentState!.validate()) return false;

    // inherited from BaseViewModel to set loading state and handle exception
    return runAsync(() async {
      // TODO: use application layer use case
      //
      // will probably use something like:
      // final result = await _forgotPasswordUseCase(
      //   ForgotPasswordParams(email: _form.email),
      // );
      // result.fold(
      //   (failure) => throw Exception(failure.message),
      //   (_) => null,
      // );

      // placeholder delay until application layer in connected
      await Future.delayed(const Duration(seconds: 1));
      // mark submission successful
      _emailSent = true;
      return true;
    });
  }

  // reset state
  // resets the forgot password screen back to its og state.
  void resetForm() {
    // hide success message
    _emailSent = false;
    // clear text field UI controller
    emailController.clear();
    // reset immutable form state
    _form = const ForgotPasswordFormModel();
    // reset ViewModel state back to idle
    setIdle();
  }

  // dispose controllers to prevent memory leaks
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
