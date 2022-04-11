import 'package:flutter/material.dart';
import 'package:jellyfin_client/dependencies.dart';
import 'package:jellyfin_client/presentation/home_view/home_view_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'presentation/home_view/home_view.dart';

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
      home: Provider<HomeViewModel>(
          create: (_) => HomeViewModel(
                authenticateUserUsecase:
                    _appDependencies.authenticateUserUsecase,
                getUserViewUsecase: _appDependencies.getUserViewUsecase,
              ),
          dispose: (_, model) => model.dispose(),
          child: const HomeView()),
    );
  }
}
