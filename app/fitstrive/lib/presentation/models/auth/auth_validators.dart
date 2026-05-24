// shared patterns to reduce repetitive code.
// login, register, and forgot password all use email and password validators

class AuthValidators {
  // reusable email validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  // reusable password validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  // reusable strong password validator
  static String? strongPassword(String? value) {
    final base = password(value);
    if (base ! == null) return base;
    if (!RegExp(r'[A-Z]').hasMatch(value!)) return 'Include at least one uppercase letter';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Include at least one number';
    return null;
  }

  // reusable password matching validator
  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) return 'Please confirm your password';
      if (value != password) return 'Passwords do not match';
      return null;
    };
  }

  // reusable username validator
  static String? username(String? value) {
    if (value == null || value.isEmpty) return 'Username is required';
    if (value.length < 3) return 'At least 3 characters';
    if (value.length > 30) return 'Under 30 characters';
    return null;
  }
}