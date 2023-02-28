import 'dart:io';

import 'package:InstantMC/resources/cubits/server/server_cubit.dart';
import 'package:universal_html/html.dart';

import 'package:InstantMC/constants/config.dart';
import 'package:InstantMC/resources/cubits/login/login_cubit.dart';
import 'package:InstantMC/resources/cubits/login_steps_switcher/login_steps_switcher_cubit.dart';
import 'package:InstantMC/resources/cubits/login_url/login_url_cubit.dart';
import 'package:InstantMC/resources/cubits/password_change/password_change_cubit.dart';
import 'package:InstantMC/resources/cubits/start/start_cubit.dart';
import 'package:InstantMC/resources/cubits/user/user_cubit.dart';
import 'package:InstantMC/resources/repositories/instantmc_repository.dart';
import 'package:InstantMC/resources/repositories/storage_repository.dart';
import 'package:InstantMC/resources/router.dart';
import 'package:InstantMC/resources/routes.dart';
import 'package:InstantMC/ui/theme_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    // resetting the route to '/' => some browsers preserve the route, we don't want that
    final String defaultRouteName = WidgetsBinding.instance.window.defaultRouteName;
    if(defaultRouteName != Routes.start) {
      SystemNavigator.routeUpdated(
          routeName: '/',
          previousRouteName: null
      );
    }
  } else {
    ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }
  runApp(InstantMC());
}

class InstantMC extends StatelessWidget {
  final StorageRepository _storageRepository = StorageRepository();
  final InstantMCRepository _instantMCRepository = InstantMCRepository();
  late final StartCubit _startCubit;
  late final LoginStepsSwitcherCubit _loginStepsSwitcherCubit;
  late final LoginCubit _loginCubit;
  late final LoginUrlCubit _loginUrlCubit;
  late final PasswordChangeCubit _passwordChangeCubit;
  late final UserCubit _userCubit;
  late final ServerCubit _serverCubit;

  InstantMC({Key? key}) : super(key: key) {
    String? targetUrl;
    if(kIsWeb) {
      targetUrl = "${window.location.protocol}//${window.location.host}";
    }
    _startCubit = StartCubit(_storageRepository, serverUrl: targetUrl);
    _loginUrlCubit = LoginUrlCubit(_instantMCRepository, _startCubit);
    _loginStepsSwitcherCubit = LoginStepsSwitcherCubit(_loginUrlCubit, _startCubit);
    _loginCubit = LoginCubit(_instantMCRepository);
    _userCubit = UserCubit(_instantMCRepository, _storageRepository, _startCubit);
    _passwordChangeCubit = PasswordChangeCubit(_instantMCRepository, _userCubit);
    _serverCubit = ServerCubit(_instantMCRepository, _userCubit);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _startCubit),
        BlocProvider(create: (_) => _loginStepsSwitcherCubit),
        BlocProvider(create: (_) => _loginCubit),
        BlocProvider(create: (_) => _loginUrlCubit),
        BlocProvider(create: (_) => _passwordChangeCubit),
        BlocProvider(create: (_) => _userCubit),
        BlocProvider(create: (_) => _serverCubit),
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
