import 'package:jellyfin_client/usecases/authenticate_use_usecase.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  String text = "Initial text";
  final AuthenticateUserUsecase authenticateUserUsecase;
  HomeViewModel({
    required this.authenticateUserUsecase,
  }) {
    authenticate();
  }

  final BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  ValueStream<bool> get isLoading => _isLoading;

  Future<void> authenticate() async {
    _isLoading.sink.add(true);
    try {
      final res = await authenticateUserUsecase.execute("harsh", "golusadh");
      text = res.token;
      _isLoading.sink.add(false);
    } catch (e) {
      text = e.toString();
      _isLoading.sink.add(false);
    }
  }

  String get testText => text;

  void dispose() {}
}
