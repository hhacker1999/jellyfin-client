import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:jellyfin_client/data/auth/auth_implementation.dart';
import 'package:jellyfin_client/data/device_info/device_info_implementation.dart';
import 'package:jellyfin_client/domain/auth/auth_facade.dart';
import 'package:jellyfin_client/domain/device_info/device_info_facade.dart';
import 'package:jellyfin_client/usecases/authenticate_use_usecase.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDependencies {
  final PackageInfo _packageInfoPlugin;

// Plugins
  late Dio _dio;
  late DeviceInfoPlugin _deviceInfoPlugin;

// Data Providers
  late DeviceInfoFacade _deviceInfoFacade;
  late AuthFacade _authFacade;

// Usecases
  late AuthenticateUserUsecase _authenticateUserUsecase;

// Initialisation
  AppDependencies(this._packageInfoPlugin) {
    // Plugins
    _dio = Dio();
    _deviceInfoPlugin = DeviceInfoPlugin();

    // Data Providers
    _deviceInfoFacade =
        DeviceInfoImplementation(_deviceInfoPlugin, _packageInfoPlugin);
    _authFacade = AuthImplementation(_dio);

    // Usecases
    _authenticateUserUsecase =
        AuthenticateUserUsecase(_deviceInfoFacade, _authFacade);
  }

  // Getters
  AuthenticateUserUsecase get authenticateUserUsecase =>
      _authenticateUserUsecase;
}
