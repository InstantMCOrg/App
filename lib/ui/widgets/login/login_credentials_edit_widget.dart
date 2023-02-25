import 'package:InstantMC/resources/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCredentialsEditWidget extends StatelessWidget {
  LoginCredentialsEditWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Username",
            ),
            onChanged: (username) =>
                context.read<LoginCubit>().changeUsername(username),
            validator: (text) {
              if (text == null) return null;
              if (text.isEmpty) {
                return "Please provide a username";
              }
            },
          ),
          const SizedBox(height: 20,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Password",
            ),
            onChanged: (password) =>
                context.read<LoginCubit>().changePassword(password),
            validator: (text) {
              if (text == null) return null;
              if (text.isEmpty) {
                return "Please provide a password";
              }
            },
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              const progressIndicator = LinearProgressIndicator();
              const defaultSize = 4.0;
              final isLoading = state is LoginStarted;

              // min height for linear progress indicators is 4.0
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutQuart,
                child: SizedBox(
                  height: isLoading ? defaultSize : 0.0,
                  child: progressIndicator,
                ),
              );
            },
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginFailed) {
                return Text(state.error.message, style: TextStyle(color: Theme
                    .of(context)
                    .colorScheme
                    .error),);
              }
              return Container();
            },
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return ElevatedButton(onPressed: state is LoginStarted ? null : () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginCubit>().login();
                }
              }, child: const Text("Login"),);
            },
          ),
        ],),
    );
  }
}
