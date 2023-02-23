import 'package:InstantMC/ui/widgets/login_steps_switcher_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 15,
              child: Container(
                color: Colors.red,
              ),
            ),
            const Flexible(
              flex: 2,
              child: LoginStepsSwitcherWidget(),
            )
          ],
        ));
  }
}
