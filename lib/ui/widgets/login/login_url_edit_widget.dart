import 'package:InstantMC/resources/cubits/login_url/login_url_cubit.dart';
import 'package:InstantMC/resources/repositories/instantmc_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../color_manager.dart';

class LoginUrlEditWidget extends StatelessWidget {
  LoginUrlEditWidget({Key? key}) : super(key: key);
  static const initialValue = "https://";
  final TextEditingController _textEditingController = TextEditingController(
      text: initialValue);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginUrlCubit, LoginUrlState>(
      builder: (context, state) {
        String? errorText;
        bool success = false;
        if(state is LoginUrlConnectionError) {
          errorText = state.exception.message;
        } else if(state is LoginUrlConnectionSuccess) {
          success = true;
        }
        return TextFormField(
          controller: _textEditingController,
          decoration: InputDecoration(
            labelText: "Enter your Server URL",
            errorText: errorText,
            suffixIcon: success ? const Icon(Icons.check_circle) : null,
            suffixIconColor: success ? ColorManager.success : null,
          ),
          onChanged: (text) => context.read<LoginUrlCubit>().textChanged(text),
        );
      },
    );
  }
}