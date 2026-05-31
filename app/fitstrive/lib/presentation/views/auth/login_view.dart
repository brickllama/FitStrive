import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth/login_viewmodel.dart';
import '../../widgets/auth/auth_widgets.dart';

// Entry point for the login screen
//
// Provides the LoginViewModel using Provider so the UI can react to state changes
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginContent();
  }
}

// internal UI for the login screen
// watches the LoginViewModel and rebuilds when state changes
class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    // listen to ViewModel changes
    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            // constrain width for better user experience on larger screens (web)
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              // form is controlled by the ViewModel formKey.
              child: Form(
                key: vm.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // header section for authentication screen
                    const FsAuthHeader(
                      title: 'Welcome back',
                      subtitle: 'Sign in to continue tracking your nutrition',
                    ),
                    const SizedBox(height: 40),

                    // Error banner shown when ViewModel is in error state
                    if (vm.hasError) ...[
                      FsErrorBanner(message: vm.errorMessage!),
                      const SizedBox(height: 16),
                    ],

                    // email input field
                    FsTextField(
                      controller: vm.emailController,
                      label: 'Email',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      // validator: vm.validateEmail,
                      onChanged: vm.onEmailChanged,
                    ),
                    const SizedBox(height: 16),

                    // password input field
                    FsPasswordField(
                      controller: vm.passwordController,
                      label: 'Password',
                      obscureText: vm.obscurePassword,
                      onToggleVisibility: vm.togglePasswordVisibility,
                      // validator: vm.validatePassword,
                      onChanged: vm.onPasswordChanged,
                      // submit when user presses enter on keyboard
                      onFieldSubmitted: (_) => _submit(context, vm),
                    ),
                    const SizedBox(height: 8),

                    // forgot password navigation
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/forgot-password'),
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // login button triggers authentication flow
                    FsPrimaryButton(
                      label: 'Sign in',
                      isLoading: vm.isLoading,
                      onPressed: () => _submit(context, vm),
                    ),
                    const SizedBox(height: 32),

                    // navigation to registration screen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/register'),
                          child: const Text('Create one'),
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

  Future<void> _submit(BuildContext context, LoginViewModel vm) async {
    final success = await vm.login();
    if (success && context.mounted) {
      // send user to dashboard
      Navigator.pushReplacementNamed(context, '/setup-profile');
    }
  }
}
