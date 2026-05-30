import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth/register_viewmodel.dart';
import '../../widgets/auth/auth_widgets.dart';

// Entry point for the register screen
//
// Provides the RegisterViewModel to the widget tree using Provider,
// so the UI can react to state changes

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: const _RegisterContent(),
    );
  }
}

// internal UI for the registration screen.
class _RegisterContent extends StatelessWidget {
  const _RegisterContent();

  @override
  Widget build(BuildContext context) {
    // listen to ViewModel changes
    final vm = context.watch<RegisterViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            // constrain width for better user experience on large screens (web)
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              // form is managed by the ViewModel
              child: Form(
                key: vm.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // header section for authentication flow
                    const FsAuthHeader(
                      title: 'Create account',
                      subtitle: 'Start tracking your nutrition today!',
                    ),
                    const SizedBox(height: 40),

                    // show error banner if ViewModel is in error state
                    if (vm.hasError) ...[
                      FsErrorBanner(message: vm.errorMessage!),
                      const SizedBox(height: 16),
                    ],

                    // username field
                    FsTextField(
                      controller: vm.usernameController,
                      label: 'Username',
                      hint: 'example: jogger03',
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      validator: vm.validateUsername,
                      onChanged: vm.onUsernameChanged,
                    ),
                    const SizedBox(height: 16),

                    // email field
                    FsTextField(
                      controller: vm.emailController,
                      label: 'Email',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: vm.validateEmail,
                      onChanged: vm.onEmailChanged,
                    ),
                    const SizedBox(height: 16),

                    // password field
                    FsPasswordField(
                      controller: vm.passwordController,
                      label: 'Password',
                      obscureText: vm.obscurePassword,
                      onToggleVisibility: vm.togglePasswordVisibility,
                      validator: vm.validatePassword,
                      onChanged: vm.onPasswordChanged,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // confirm password field
                    FsPasswordField(
                      controller: vm.confirmPasswordController,
                      label: 'Confirm password',
                      obscureText: vm.obscureConfirm,
                      onToggleVisibility: vm.toggleConfirmVisibility,
                      validator: vm.validateConfirmPassword,
                      onChanged: vm.onConfirmPasswordChanged,
                      // submit
                      onFieldSubmitted: (_) => _submit(context, vm),
                    ),
                    const SizedBox(height: 32),

                    // submit button for registration
                    FsPrimaryButton(
                      label: 'Create account',
                      isLoading: vm.isLoading,
                      onPressed: () => _submit(context, vm),
                    ),
                    const SizedBox(height: 24),

                    // navigation back to login screen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Sign in'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // handles regsistration form submission
  // calls the ViewModel and navigates on success
  Future<void> _submit(BuildContext context, RegisterViewModel vm) async {
    final success = await vm.register();
    // only navigate if registration succeeded and widget is still mounted
    if (success && context.mounted) {
      // TODO: send user to daily intake stats
    }
  }
}