import 'package:flutter/material.dart';
import 'package:jellyfin_client/app/routes.dart';
import 'package:jellyfin_client/presentation/helper/stream_listener_and_builder.dart';
import 'package:provider/provider.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _serverIdController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _serverIdController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (_, model, __) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: StreamListenerAndBuilder<LoginViewState>(
                stream: model.state,
                listener: (listeningState) {
                  if (listeningState is LoginViewLoggedIn) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.homeRoute);
                  }
                },
                builder: (_, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextField(
                        controller: _serverIdController,
                        decoration: const InputDecoration(
                          label: Text("Server Id"),
                        ),
                      ),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          label: Text("User name"),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          label: Text("password"),
                        ),
                      ),
                      if (state is LoginViewError) Text(state.error),
                      ElevatedButton(
                        onPressed: () {
                          model.authenticateUser(
                              _serverIdController.text,
                              _usernameController.text,
                              _passwordController.text);
                        },
                        child: state is LoginViewLoading
                            ? const CircularProgressIndicator()
                            : const Text("Login"),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
