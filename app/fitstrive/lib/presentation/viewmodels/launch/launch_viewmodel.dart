import '../base_viewmodel.dart';
import '../../models/launch/launch_model.dart';

// ViewModel responsible for application launch flow
// TODO: connect to application layer

class LaunchViewModel extends BaseViewModel {
  AuthMode? _authMode;
  AuthMode? get authMode => _authMode;

  bool get isGuest => _authMode == AuthMode.guest;
  bool get isAccount => _authMode == AuthMode.account;

  // called when the user selects 'contunie as guest'
  // no async needed, just sets local auth mode.
  // view navigates to dashboard on call.
  void continueAsGuest() {
    _authMode = AuthMode.guest;
    notifyListeners();
  }

  // called when the user selects 'sign in/register'
  // no async needed, just sets local auth mode
  // view navigates to login on call
  void continueAsAccount() {
    _authMode = AuthMode.account;
    notifyListeners();
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