import 'package:flutter/material.dart';
import 'package:jellyfin_client/presentation/home_view/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (_, model, __) => Scaffold(
        body: Center(
          child: Text(model.testText),
        ),
      ),
    );
  }
}
