import 'package:InstantMC/resources/cubits/login_url/login_url_cubit.dart';
import 'package:InstantMC/ui/widgets/instantmc_widget.dart';
import 'package:InstantMC/ui/widgets/login/login_url_edit_widget.dart';
import 'package:InstantMC/ui/widgets/max_size_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUrlStepFragment extends StatelessWidget {
  const LoginUrlStepFragment({Key? key}) : super(key: key);
  final double _iconMaxSize = 200;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          MaxSizeContainer(
            maxWidth: _iconMaxSize,
            maxHeight: _iconMaxSize,
            child: const InstantMCWidget.loading(),
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Effortless Mc server management.",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "InstantMC provides everything you need.\nInstantly.",
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              const LoginUrlEditWidget(),
              BlocBuilder<LoginUrlCubit, LoginUrlState>(
                builder: (context, state) {
                  const progressIndicator = LinearProgressIndicator();
                  const defaultSize = 4.0;
                  final isLoading = state is LoginUrlChecking;

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
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<LoginUrlCubit, LoginUrlState>(
                builder: (context, state) {
                  final disabled = state is LoginUrlChecking;
                  return ElevatedButton(
                      onPressed: () => disabled ? null : context.read<LoginUrlCubit>().check(),
                      child: const Text("Connect"));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
