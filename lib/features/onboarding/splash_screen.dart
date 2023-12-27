// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/stores/auth_store.dart';
import '../../utils/const.dart';
import '../../utils/routes/app_router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  Future<void> initApis() async {
    logger.d("initApis");
    if (!context.read<AuthStore>().isAuthenticated) {
      // await context.read<AuthStore>().testToken();
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceIn,
    );
    _animationController.forward();
    super.initState();
    handleNavigation();
  }

  void handleNavigation() async {
    await initApis();

    // wait 1 second
    await Future.delayed(const Duration(milliseconds: 2000));

    if (context.read<AuthStore>().isAuthenticated || true) {
      if (context.mounted) {
        AutoRouter.of(context).replace(const MainScaffoldRoute());
      }
    } else {
      if (context.mounted) {
        AutoRouter.of(context).replace(const OnboardingRoute());
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/images/logo.png'),
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
