import 'package:flutter/foundation.dart';

// Represent the current UI state of the ViewModel

enum ViewState {
  idle,
  loading,
  success,
  error
}

// base class for all ViewModels in the MVVM architecture
// extends ChangeNotifier so Flutter widgets can listen for updates
abstract class BaseViewModel extends ChangeNotifier {
  // current state of the ViewModel starts in idle by default
  ViewState _state = ViewState.idle;
  // store latest error message when an operation fails
  String? _errorMessage;

  // public getters - read only access
  ViewState get state => _state;
  String? get errorMessage => _errorMessage;

  // convenience state getters
  bool get isLoading => _state == ViewState.loading;
  bool get isSuccess => _state == ViewState.success;
  bool get hasError => _state == ViewState.error;
  bool get isIdle => _state == ViewState.idle;

  // sets the ViewModel state to loading
  // typically called before starting an async operation
  void setLoading() {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();
  }

  // set the ViewModel state to success
  void setSuccess() {
    _state = ViewState.success;
    _errorMessage = null;
    notifyListeners();
  }

  // set the ViewModel state to error
  void setError(String message) {
    _state = ViewState.error;
    _errorMessage = message;
    notifyListeners();
  }

  // reset the ViewModel back to its default idle state
  void setIdle() {
    _state = ViewState.idle;
    _errorMessage = null;
    notifyListeners();
  }

  // wraps any async action with loading/error/success state handling.
  // returns true on success, false on failure.
  Future<bool> runAsync(Future<void> Function() action) async {
    try {
      setLoading();
      await action();
      setSuccess();
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    }
  }

  // override dispose in subclasses to clean up controllers/resources
  @override
  void dispose() {
    super.dispose();
  }
}