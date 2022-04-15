import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jellyfin_client/data/auth/auth_implementation.dart';
import 'package:jellyfin_client/data/device_info/device_info_implementation.dart';
import 'package:jellyfin_client/data/jellyfin/jellyfin_implementation.dart';
import 'package:jellyfin_client/data/storage/storage_implementation.dart';
import 'package:jellyfin_client/domain/auth/auth_facade.dart';
import 'package:jellyfin_client/domain/device_info/device_info_facade.dart';
import 'package:jellyfin_client/domain/jellyfin/jelly_facade.dart';
import 'package:jellyfin_client/domain/storage/storage_facade.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'domain/usecases/authenticate_use_usecase.dart';
import 'domain/usecases/create_header_usecase.dart';
import 'domain/usecases/get_resumable_items_usecase.dart';
import 'domain/usecases/get_user_views_usecase.dart';

class AppDependencies {
  final PackageInfo _packageInfoPlugin;

// Plugins
  late Dio _dio;
  late DeviceInfoPlugin _deviceInfoPlugin;
  late FlutterSecureStorage _flutterSecureStorage;

// Data Providers
  late DeviceInfoFacade _deviceInfoFacade;
  late AuthFacade _authFacade;
  late StorageFacade _storageFacade;
  late JellyFacade _jellyFacade;

// Usecases
  late AuthenticateUserUsecase _authenticateUserUsecase;
  late GetUserViewUsecase _getUserViewUsecase;
  late CreateHeaderUsecase _createHeaderUsecase;
  late GetResumableItemsUsecase _getResumableItemsUsecase;

// Initialisation
  AppDependencies(this._packageInfoPlugin) {
    // Plugins
    _dio = Dio();
    _deviceInfoPlugin = DeviceInfoPlugin();
    _flutterSecureStorage = const FlutterSecureStorage();

    // Data Providers
    _deviceInfoFacade =
        DeviceInfoImplementation(_deviceInfoPlugin, _packageInfoPlugin);
    _authFacade = AuthImplementation(_dio);
    _storageFacade = StorageImplementation(_flutterSecureStorage);
    _jellyFacade = JellyfinImplementation(_dio);

    // Usecases
    _authenticateUserUsecase =
        AuthenticateUserUsecase(_deviceInfoFacade, _authFacade, _storageFacade);
    _getUserViewUsecase = GetUserViewUsecase(_jellyFacade, _storageFacade);
    _createHeaderUsecase =
        CreateHeaderUsecase(_storageFacade, _deviceInfoFacade);
    _getResumableItemsUsecase = GetResumableItemsUsecase(
        _createHeaderUsecase, _jellyFacade, _storageFacade);
  }

  // Getters
  AuthenticateUserUsecase get authenticateUserUsecase =>
      _authenticateUserUsecase;
  GetUserViewUsecase get getUserViewUsecase => _getUserViewUsecase;
  GetResumableItemsUsecase get getResumableItemsUsecase =>
      _getResumableItemsUsecase;
}
