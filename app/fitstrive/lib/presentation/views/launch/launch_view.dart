import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/launch/launch_viewmodel.dart';
import '../../widgets/auth/auth_widgets.dart';

// Entry point for the launch screen
//
// First screen the user sees and determines whether they enter
// as a guest (local only), or as an account holder (local and server)
class LaunchView extends StatelessWidget {
  const LaunchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LaunchViewModel()..checkExistingSession(),
      child: const _LaunchContent(),
    );
  }
}

// internal ui for the launch screen
// watches the LaunchViewModel and navigates when auth mode is set
class _LaunchContent extends StatelessWidget {
  const _LaunchContent();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LaunchViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 2),

                  // app logo and name
                  const _LaunchHeader(),

                  const Spacer(flex: 2),

                  if (vm.hasError) ...[
                    FsErrorBanner(message: vm.errorMessage!),
                    const SizedBox(height: 24),
                  ],

                  FsPrimaryButton(
                    label: 'Sign in / Register',
                    isLoading: vm.isLoading && vm.isAccount,
                    onPressed: () => _onContinueAsAccount(context, vm),
                  ),
                  const SizedBox(height: 12),

                  // continue as guest button
                  _GuestButton(
                    isLoading: vm.isLoading && vm.isGuest,
                    onPressed: () => _onContinueAsGuest(context, vm),
                  ),

                  const Spacer(flex: 1),

                  // privacy note stating that user data is saved locally on device
                  const _PrivacyNote(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _onContinueAsAccount(
      BuildContext context, LaunchViewModel vm) async {
    final success = await vm.continueAsAccount();
    if (success && context.mounted) {
      Navigator.pushNamed(context, '/login');
    }
  }

  Future<void> _onContinueAsGuest(
      BuildContext context, LaunchViewModel vm) async {
    final success = await vm.continueAsGuest();
    if (success && context.mounted) {
    }
  }
}

// launch header, logo, app name, subtitle

class _LaunchHeader extends StatelessWidget {
  const _LaunchHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.fitness_center,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'FitStrive',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track your nutrition!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}

// guest button, less style detail than the sign in / register button
class _GuestButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const _GuestButton({required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              )
            : const Text('Continue as guest'),
      ),
    );
  }
}

// privacy note, reminds users all data stays on device
class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline,
          size: 14,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(
          'Your data is saved locally on your device',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}