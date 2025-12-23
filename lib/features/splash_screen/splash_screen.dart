import 'package:flutter/material.dart';
import 'package:yatra/core/utils/route_generator.dart';
import 'package:yatra/core/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      RouteGenerator.navigateToPageWithoutStack(
        context,
        Routes.onboardingRoute,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Image.asset("assets/images/yatra1.png"),
            ),
          ),
        ],
      ),
    );
  }
}
