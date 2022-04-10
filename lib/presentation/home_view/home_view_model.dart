import 'package:jellyfin_client/usecases/authenticate_use_usecase.dart';

class HomeViewModel {
  final AuthenticateUserUsecase authenticateUserUsecase;
  HomeViewModel({
    required this.authenticateUserUsecase,
  });

  String get testText => "Text from view model";

  void dispose() {}
}
