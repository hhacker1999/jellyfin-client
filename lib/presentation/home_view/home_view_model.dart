import 'package:jellyfin_client/usecases/authenticate_use_usecase.dart';
import 'package:jellyfin_client/usecases/get_user_views_usecase.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  final AuthenticateUserUsecase authenticateUserUsecase;
  final GetUserViewUsecase getUserViewUsecase;
  String text = "Initial text";
  HomeViewModel(
      {required this.authenticateUserUsecase,
      required this.getUserViewUsecase}) {
    //authenticate();
    getUserViewUsecase.execute();
  }

  final BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  ValueStream<bool> get isLoading => _isLoading;

  Future<void> authenticate() async {
    _isLoading.sink.add(true);
    try {
      await authenticateUserUsecase.execute("harsh", "golusadh");
      _isLoading.sink.add(false);
    } catch (e) {
      text = e.toString();
      _isLoading.sink.add(false);
    }
  }

  String get testText => text;

  void dispose() {}
}
