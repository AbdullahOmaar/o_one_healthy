import 'dart:async';

import 'package:app/routes/app_routes.dart';
import 'package:app/screens/base/root_dialog.dart';
import 'package:app/util/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const routeName = "/SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isJailBroken = false;
  bool isRealDevice = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    Timer(const Duration(seconds: 3), _onTimeOut);
  }

  _onTimeOut() {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
    // if (Environment.isRootCheckerEnabled && (!isRealDevice || isJailBroken)) {
    //   _dialogRoute();
    // } else {
    //   Navigator.pushReplacementNamed(
    //       context, _rememberMe ? AppRoutes.kHome : AppRoutes.kWelcomeOptions);
    // }
  }

  Future<void> initPlatformState() async {
    // _rememberMe = await LocalStorage.rememberMe();

    // try {
    //   isJailBroken = await SafeDevice.isJailBroken;
    //   isRealDevice = await SafeDevice.isRealDevice;
    // } catch (error) {
    //   print(error);
    // }

    setState(() {});
  }

  void _dialogRoute() {
    showDialog(
        context: context,
        builder: (context) {
          return const RootDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() => Container(
        decoration: BoxDecoration(
          color: ThemeColors.kPrimary,
        ),
        foregroundDecoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/logo/splash.png'),
                fit: BoxFit.fill)),
        child: const Center(
          child: Image(image: AssetImage('assets/images/logo/splash.png')),
        ),
      );
}
