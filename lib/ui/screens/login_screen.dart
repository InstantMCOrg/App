import 'package:InstantMC/resources/cubits/login_steps_switcher/login_steps_switcher_cubit.dart';
import 'package:InstantMC/ui/fragments/login_screen/login_url_step_fragment.dart';
import 'package:InstantMC/ui/widgets/login_steps_switcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight; // available height minus appbar height

            return SingleChildScrollView(
              // we need this weird hacky way to make sure the step selector widget always aligns to the bottom to ensure the ui is consistent
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: maxHeight
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<LoginStepsSwitcherCubit, LoginStepsSwitcherState>(
                      buildWhen: (oldState, newState) => newState is LoginStepsSwitcherUrlStep || newState is LoginStepsSwitcherCredentialsStep,
                      builder: (context, state) {
                        if(state is LoginStepsSwitcherCredentialsStep) {

                        }
                        return const LoginUrlStepFragment();
                      },
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: LoginStepsSwitcherWidget.preferredSize,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: LoginStepsSwitcherWidget(),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ));
  }
}
