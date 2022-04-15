import 'package:jellyfin_client/domain/usecases/authenticate_use_usecase.dart';
import 'package:jellyfin_client/domain/usecases/get_resumable_items_usecase.dart';
import 'package:jellyfin_client/domain/usecases/get_user_views_usecase.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  final AuthenticateUserUsecase authenticateUserUsecase;
  final GetUserViewUsecase getUserViewUsecase;
  final GetResumableItemsUsecase getResumableItemsUsecase;
  String text = "Initial text";
  HomeViewModel(
      {required this.authenticateUserUsecase,
      required this.getUserViewUsecase,
      required this.getResumableItemsUsecase}) {
    authenticate();
  }

  final BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  ValueStream<bool> get isLoading => _isLoading;

  Future<void> authenticate() async {
    _isLoading.sink.add(true);
    await authenticateUserUsecase.execute("harsh", "golusadh");
    final item = await getResumableItemsUsecase.execute();
    _isLoading.sink.add(false);
    _isLoading.sink.add(false);
  }

  String get testText => text;

  void dispose() {}
}
