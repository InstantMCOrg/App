import 'package:InstantMC/constants/config.dart';
import 'package:InstantMC/resources/cubits/login_steps_switcher/login_steps_switcher_cubit.dart';
import 'package:InstantMC/resources/cubits/start/start_cubit.dart';
import 'package:InstantMC/resources/repositories/storage_repository.dart';
import 'package:InstantMC/resources/router.dart';
import 'package:InstantMC/ui/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InstantMC());
}

class InstantMC extends StatelessWidget {
  final StorageRepository _storageRepository = StorageRepository();
  late final StartCubit _startCubit;
  late final LoginStepsSwitcherCubit _loginStepsSwitcherCubit;

  InstantMC({Key? key}) : super(key: key) {
    _startCubit = StartCubit(_storageRepository);
    _loginStepsSwitcherCubit = LoginStepsSwitcherCubit();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _startCubit),
        BlocProvider(create: (_) => _loginStepsSwitcherCubit),
      ],
      child: MaterialApp(
        title: kAppName,
        initialRoute: "/",
        onGenerateRoute: AppRouter.route,
        theme: ThemeManager.dark(),
      ),
    );
  }
}
