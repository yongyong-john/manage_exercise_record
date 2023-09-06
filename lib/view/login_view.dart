import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/login/login_bloc.dart';
import 'package:manage_exercise_records/bloc/login/login_event.dart';
import 'package:manage_exercise_records/bloc/login/login_state.dart';
import 'package:manage_exercise_records/common/widget/snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;

  void _performLogin() {
    BlocProvider.of<LoginBloc>(context).add(CheckMatchPassword(passwordController.text));
  }

  void _performLogout() {
    setState(() {
      BlocProvider.of<LoginBloc>(context).add(CheckMatchPassword(null));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          isLoggedIn = true;
        } else if (state is LoginNotYet) {
          isLoggedIn = false;
          passwordController.text = '';
        } else if (state is LoginFailure) {
          snackBarWithText(context, 'Failed to login. Please check password and try again.');
        } else if (state is LoginLoading) {
          return const SizedBox(
            width: 30,
            height: 30,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (isLoggedIn) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: _performLogout,
                child: const Text('Logout'),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _performLogin,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
