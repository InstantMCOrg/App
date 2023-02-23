import 'package:InstantMC/resources/cubits/login_steps_switcher/login_steps_switcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../color_manager.dart';

class LoginStepsSwitcherWidget extends StatelessWidget {
  const LoginStepsSwitcherWidget({Key? key}) : super(key: key);
  final double radius = 25;
  static const switchAnimationDuration = Duration(milliseconds: 700);
  static const switchNotAllowedAnimationDuration = Duration(milliseconds: 75);
  final _animationCurve = Curves.easeOutQuint;
  final String _urlStepText = "Url";
  final String _credentialsStepText = "Credentials";

  @override
  Widget build(BuildContext context) {
    final switcherBackgroundTextStyle = Theme.of(context).textTheme.labelMedium;
    final switcherForegroundTextStyle = Theme.of(context)
        .textTheme
        .labelMedium
        ?.copyWith(color: ColorManager.black);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Builder(builder: (context) {
        final contentWidth = MediaQuery.of(context).size.width;
        final contentHeight = MediaQuery.of(context).size.height;
        final chooserSize = contentWidth / 2;

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => context.read<LoginStepsSwitcherCubit>().toggle(),
                child: SizedBox(
                  height: contentHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            _urlStepText,
                            style: switcherBackgroundTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            _credentialsStepText,
                            style: switcherBackgroundTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<LoginStepsSwitcherCubit, LoginStepsSwitcherState>(
              buildWhen: (oldState, newState) =>
                  newState is LoginStepsSwitcherUrlStep ||
                  newState is LoginStepsSwitcherCredentialsStep ||
                  newState is LoginStepsSwitcherCredentialsStepBlocked,
              builder: (context, state) {
                // in this case the white bar should turn red and indicate no movement is allowed
                final showActionIsBlocked = state is LoginStepsSwitcherCredentialsStepBlocked;

                final align = state is LoginStepsSwitcherUrlStep
                    ? Alignment.centerLeft
                    : Alignment.centerRight;
                final text = state is LoginStepsSwitcherUrlStep || showActionIsBlocked
                    ? _urlStepText
                    : _credentialsStepText;

                return AnimatedAlign(
                  alignment: align,
                  curve: _animationCurve,
                  duration: switchAnimationDuration,
                  child: SizedBox(
                    width: chooserSize,
                    // white chooser bar
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: AnimatedContainer(
                        width: double.infinity,
                        height: double.infinity,
                        color: showActionIsBlocked ? ColorManager.error : ColorManager.white,
                        alignment: Alignment.center,
                        duration: switchNotAllowedAnimationDuration,
                        child: Text(
                          text,
                          style: switcherForegroundTextStyle,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
