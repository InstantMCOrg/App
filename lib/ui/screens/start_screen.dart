import 'package:InstantMC/constants/ui.dart';
import 'package:InstantMC/resources/routes.dart';
import 'package:InstantMC/ui/widgets/instantmc_widget.dart';
import 'package:InstantMC/ui/widgets/max_size_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/cubits/start/start_cubit.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocConsumer<StartCubit, StartState>(
      listener: (context, state) {
        if(state is StartServerUrlRequired) {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      },
      builder: (context, state) {
        if (state is StartLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MaxSizeContainer(
                  maxWidth: kLoadingIconDefaultSize,
                  maxHeight: kLoadingIconDefaultSize,
                  child: InstantMCWidget.loading()),
              const SizedBox(height: 20,),
              Text("Loading", style: Theme.of(context).textTheme.titleLarge,)
            ],
          );
        }
        return Container();
      },
    ));
  }
}
