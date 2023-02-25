import 'package:InstantMC/resources/cubits/login/login_cubit.dart';
import 'package:InstantMC/resources/cubits/login_url/login_url_cubit.dart';
import 'package:InstantMC/resources/routes.dart';
import 'package:InstantMC/ui/widgets/login/login_credentials_edit_widget.dart';
import 'package:InstantMC/ui/widgets/max_size_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/cubits/user/user_cubit.dart';
import '../../color_manager.dart';

class LoginCredentialsStepFragment extends StatelessWidget {
  const LoginCredentialsStepFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<LoginUrlCubit, LoginUrlState>(
          builder: (context, state) {
            if (state is LoginUrlConnectionSuccess) {
              return MaxSizeContainer(
                  maxWidth: 300,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.success),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Connection to ${state.uri.host} successful",
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                  ));
            }
            return Container();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Finish the setup by logging in with your credentials",
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if(state is LoginSuccess) {
              // redirect to dashboard
              Navigator.pushReplacementNamed(context, Routes.dashboard);
            } else if(state is LoginSuccessPasswordChangeRequired) {
              context.read<UserCubit>().login(state.token);
              Navigator.pushReplacementNamed(context, Routes.passwordChange);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginCredentialsEditWidget(),
          ),
        ),
      ],
    );
  }
}
