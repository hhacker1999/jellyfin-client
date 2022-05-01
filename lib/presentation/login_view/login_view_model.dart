import 'package:rxdart/rxdart.dart';

import 'package:jellyfin_client/domain/usecases/authenticate_use_usecase.dart';

class LoginViewModel {
  final AuthenticateUserUsecase _authenticateUserUsecase;
  final BehaviorSubject<LoginViewState> _stateSubject =
      BehaviorSubject.seeded(LoginViewInitial());

  LoginViewModel(this._authenticateUserUsecase);

  ValueStream<LoginViewState> get state => _stateSubject;

  Future<void> authenticateUser(
      String serverid, String username, String password) async {
    _stateSubject.add(LoginViewLoading());
    try {
      await _authenticateUserUsecase.execute(username, password);
      _stateSubject.add(LoginViewLoggedIn());
    } catch (e) {
      _stateSubject.add(LoginViewError(error: e.toString()));
    }
  }

  void dispose() {
    _stateSubject.close();
  }
}

abstract class LoginViewState {}

class LoginViewError implements LoginViewState {
  final String error;
  const LoginViewError({
    required this.error,
  });
}

class LoginViewLoading implements LoginViewState {}

class LoginViewInitial implements LoginViewState {}

class LoginViewLoggedIn implements LoginViewState {}
