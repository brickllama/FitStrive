import 'package:flutter/material.dart';

// Reusable authentication UI widgets for FitStrive

class FsTextField extends StatelessWidget {
  // controller to read/write the field value
  final TextEditingController controller;
  // label displayed above the input field
  final String label;
  // place holder text to give an example of a valid entry (e.g. you@example.com)
  final String? hint;
  // keyboard type example: email or numeric keyboard
  final TextInputType keyboardType;
  // action button behavior: next / done
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;

  const FsTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      autofocus: autofocus,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

// Password Field - text field and visibility toggle
// built on top of FsTextField and includes password visibilty toggle and keyboard type
class FsPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;

  const FsPasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.onToggleVisibility,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return FsTextField(
      controller: controller,
      label: label,
      // hide/show password
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      // visibilty toggle button
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: onToggleVisibility,
        tooltip: obscureText ? 'Show password' : 'Hide password',
      ),
    );
  }
}

// Primary action button - full-width, handles loading state
// supports loading states, disabled state while executing operations,
// and consistent styling and sizing
class FsPrimaryButton extends StatelessWidget {
  final String label;
  // callback triggered when button is pressed
  final VoidCallback? onPressed;
  // when true, a button has been pressed and an operation is executing
  // so loading indicator is shown
  final bool isLoading;

  const FsPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        // disable button while loading
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            // loading indicator: circular progress indicator
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              )
            : Text(label),
      ),
    );
  }
}

// Error Banner
// reusable styled error message banner
// handles authentication fails, validation error, network or API error
class FsErrorBanner extends StatelessWidget {
  final String message;

  const FsErrorBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // error icon
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.onErrorContainer,
            size: 18,
          ),
          const SizedBox(width: 10),
          // error text
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// Authentication screen header - logo. title, subtitle
// shared authentication header widget
// displays app/logo icon, screen titel, subtitle, and prompt instructions
// used for login, register, and forgot password
class FsAuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const FsAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo placeholder - fitness icon
        // can be replaced with image
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.fitness_center,
            size: 36,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          // screen title
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          // subtitle/instructions
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}