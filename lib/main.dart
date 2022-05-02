import 'package:flutter/material.dart';
import 'package:jellyfin_client/app/routes.dart';
import 'package:jellyfin_client/dependencies.dart';
import 'package:jellyfin_client/presentation/home_view/home_view_model.dart';
import 'package:jellyfin_client/presentation/login_view/login_view_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'presentation/home_view/home_view.dart';
import 'presentation/login_view/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final infoPlugin = await PackageInfo.fromPlatform();
  runApp(JellyfinClient(
    deviceInfoPlugin: infoPlugin,
  ));
}

class JellyfinClient extends StatefulWidget {
  const JellyfinClient({Key? key, required this.deviceInfoPlugin})
      : super(key: key);
  final PackageInfo deviceInfoPlugin;

  @override
  State<JellyfinClient> createState() => _JellyfinClientState();
}

class _JellyfinClientState extends State<JellyfinClient> {
  late AppDependencies _appDependencies;

  @override
  void initState() {
    super.initState();
    _appDependencies = AppDependencies(widget.deviceInfoPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.loginRoute,
      onGenerateRoute: (route) {
        switch (route.name) {
          case AppRoutes.homeRoute:
            return MaterialPageRoute(
              builder: (_) => Provider<HomeViewModel>(
                create: (_) => HomeViewModel(
                    getResumableItemsUsecase:
                        _appDependencies.getResumableItemsUsecase,
                    getTmdbTrendingUsecase:
                        _appDependencies.getTmdbTrendingUsecase),
                child: const HomeView(),
                dispose: (_, model) => model.dispose(),
              ),
            );
          case AppRoutes.loginRoute:
            return MaterialPageRoute(
              builder: (_) => Provider<LoginViewModel>(
                create: (_) => LoginViewModel(
                  _appDependencies.authenticateUserUsecase,
                ),
                child: const LoginView(),
                dispose: (_, model) => model.dispose(),
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => Provider<HomeViewModel>(
                create: (_) => HomeViewModel(
                    getResumableItemsUsecase:
                        _appDependencies.getResumableItemsUsecase,
                    getTmdbTrendingUsecase:
                        _appDependencies.getTmdbTrendingUsecase),
                child: const HomeView(),
                dispose: (_, model) => model.dispose(),
              ),
            );
        }
      },
    );
  }
}
