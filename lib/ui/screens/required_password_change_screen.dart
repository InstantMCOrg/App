import 'package:InstantMC/resources/cubits/password_change/password_change_cubit.dart';
import 'package:InstantMC/resources/cubits/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/routes.dart';

class RequiredPasswordChangeScreen extends StatelessWidget {
  RequiredPasswordChangeScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password change"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "In order to keep your account safe you need to change your password",
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "New password",
                        ),
                        controller: _passwordController,
                        validator: (password) {
                          if (password == null) {
                            return null;
                          } else if (password.isEmpty) {
                            return "Password can't be empty";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Confirm password",
                        ),
                        controller: _confirmPasswordController,
                        validator: (confirmedPassword) {
                          if (_passwordController.text != confirmedPassword) {
                            return "Password doesn't match";
                          }
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              BlocListener<PasswordChangeCubit, PasswordChangeState>(
                listener: (context, state) {
                  if(state is PasswordChangeSuccess) {
                    // navigate to dashboard
                    context.read<UserCubit>().login(state.newToken);
                    Navigator.pushReplacementNamed(context, Routes.dashboard);
                  } else if(state is PasswordChangeFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occured: ${state.exception.message}")));
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<PasswordChangeCubit>()
                          .changePassword(_passwordController.text);
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
