import 'package:InstantMC/constants/ui.dart';
import 'package:InstantMC/resources/routes.dart';
import 'package:InstantMC/ui/widgets/instantmc_widget.dart';
import 'package:InstantMC/ui/widgets/max_size_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/cubits/start/start_cubit.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocConsumer<StartCubit, StartState>(
      listener: reactToState,
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
        return Container(child: Text(state.toString()),);
      },
    ));
  }

  void reactToState(BuildContext context, StartState state) {
    if(state is StartServerUrlRequired || state is StartServerCredentialsRequired) {
      Navigator.pushReplacementNamed(context, Routes.login);
    } else if(state is StartSavedServerFound) {
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          //we need to check if state got missed in the widget
      final startState = context.read<StartCubit>().state;
      reactToState(context, startState);
    });
  }
}
