import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth/forgot_password_viewmodel.dart';
import '../../widgets/auth/auth_widgets.dart';

// Entry point to the forgot password screen
// Sets the ViewModel using Provider and injects it into the widget tree.
// Provider = state management
// Makes it possible for the UI to actively listen for state changes

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(),
      child: const _ForgotPasswordContent(),
    );
  }
}

// internal UI container for the forgot password feature
//
// watches the ViewModel and switches between email input form and success confirmation panel
class _ForgotPasswordContent extends StatelessWidget {
  const _ForgotPasswordContent();

  @override
  Widget build(BuildContext context) {
    // listen to ViewModel changes and rebuilt when state updates
    final vm = context.watch<ForgotPasswordViewModel>();

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
            // constrain width for better user exerience on larger screens (web)
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              // switch UI based on wether the email was successfully
              child: vm.emailSent
                  ? _ConfirmationPanel(vm: vm)
                  : _FormPanel(vm: vm),
            ),
          ),
        ),
      ),
    );
  }
}

// Forgot password form UI

// form panel responsible for collecting user email input
// handles validates, submission, error display
class _FormPanel extends StatelessWidget {
  final ForgotPasswordViewModel vm;
  const _FormPanel({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: vm.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FsAuthHeader(
            title: 'Reset password',
            subtitle: "Enter your email to receive a reset link",
          ),
          const SizedBox(height: 40),

          // display error banner if ViewModel is in error state
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
            autofocus: true,
            // validator: vm.validateEmail,
            onChanged: vm.onEmailChanged,
            // submit when user presses "enter" on keyboard
            onFieldSubmitted: (_) => _submit(context),
          ),
          const SizedBox(height: 32),

          // submit button triggers password reset
          FsPrimaryButton(
            label: 'Send reset link',
            isLoading: vm.isLoading,
            onPressed: () => _submit(context),
          ),
          const SizedBox(height: 24),

          // navigation back to login screen
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to sign in'),
            ),
          ),
        ],
      ),
    );
  }

  // hanldes form submission by calling ViewModel logic
  Future<void> _submit(BuildContext context) async {
    await vm.sendResetEmail();
    // emailSent flag on the VM triggers the confirmation panel rebuild
  }
}

// Success confirmation panel

// success panel shown after reset email is sent
class _ConfirmationPanel extends StatelessWidget {
  final ForgotPasswordViewModel vm;
  const _ConfirmationPanel({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),

        // success icon indicator
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_read_outlined,
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Check your inbox',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Text(
          'A password reset link has been sent to ${vm.emailController.text}. '
          'Check your spam folder if you don\'t see it.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 40),

        FsPrimaryButton(
          label: 'Back to sign in',
          onPressed: () =>
              Navigator.popUntil(context, ModalRoute.withName('/login')),
        ),
        const SizedBox(height: 16),

        // option to restart flow with different email
        Center(
          child: TextButton(
            onPressed: vm.resetForm,
            child: const Text('Try a different email'),
          ),
        ),
      ],
    );
  }
}
