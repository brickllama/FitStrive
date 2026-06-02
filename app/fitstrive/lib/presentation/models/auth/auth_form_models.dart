// Presentation-layer-only data shapes, not domain entities.
// They hold what's currently typed in the authentication form,
// and get passed to the use case when submitting.
// Separates what the user typed from what the domain needs.

// store the current values typed into the login form.
class LoginFormModel {
  // user email input
  final String email;
  // user password input
  final String password;

  // creates an immutable login form model
  const LoginFormModel({
    // default values are empty so the form starts blank
    this.email = '',
    this.password = '',
  });

  // returns a new instance with updates field values
  LoginFormModel copyWith({String? email, String? password}) {
    return LoginFormModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

// model representing the register/sign up form state
class RegisterFormModel {
  final String username;
  final String email;
  final String firstName;
  final String? lastName;
  final String password;
  final String confirmPassword;

  // creates immutable register form model
  const RegisterFormModel({
    this.username = '',
    this.email = '',
    this.firstName = '',
    this.lastName,
    this.password = '',
    this.confirmPassword = '',
  });

  // returns a new immutable instance with updates values
  RegisterFormModel copyWith({
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterFormModel(
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}

// model representing the forgot password state
class ForgotPasswordFormModel {
  // email entered for password recovery
  final String email;

  // immutable forgot password form model
  const ForgotPasswordFormModel({this.email = ''});

  // returns a new immutable instance with updates values
  ForgotPasswordFormModel copyWith({String? email}) {
    return ForgotPasswordFormModel(email: email ?? this.email);
  }
}
