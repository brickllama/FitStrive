import '../base_viewmodel.dart';
import '../../models/launch/launch_model.dart';

// ViewModel responsible for application launch flow
// TODO: import from application layer

class LaunchViewModel extends BaseViewModel {
  AuthMode? _authMode;
  AuthMode? get authMode => _authMode;

  bool get isGuest => _authMode == AuthMode.guest;
  bool get isAccount => _authMode == AuthMode.account;

  // called when the user selects 'continue as guest'
  // sets auth mode to guest, view navigates to auth screens (or dashboard)
  Future<bool> continueAsGuest() async {
    return runAsync(() async {
      _authMode = AuthMode.guest;
      // TODO: connect to application layer
    });
  }

  // called when the user selects 'sign in/register'
  // sets auth mode to account, view navigates to auth screens
  Future<bool> continueAsAccount() async {
    return runAsync(() async {
      _authMode = AuthMode.account;
      // TODO: connect to application layer
    });
  }

  // checks if a session already exists on app launch
  // if so, the View skips the launch screen entirely to user dashboard
  Future<void> checkExistingSession() async {
    await runAsync(() async {
      // TODO: connect to application layer
      //
      // something like:
      // final result = await _checkSessionUseCase(NoParams());
      // result.fold(
      //   (failure) => _authMode = null,
      //   (session) => _authMode = session.isGuest ? AuthMode.guest : AuthMode.account,
      // );

      // place holder, no existing session
      _authMode = null;
    });
  }
}