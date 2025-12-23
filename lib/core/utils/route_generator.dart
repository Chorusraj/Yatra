import 'package:flutter/material.dart';
import 'package:yatra/core/utils/routes.dart';
import 'package:yatra/features/add_place/pages/places_list_screen.dart';
import 'package:yatra/features/auth/model/user.dart';
import 'package:yatra/features/auth/pages/login_page.dart';
import 'package:yatra/features/auth/pages/signup_page.dart';
import 'package:yatra/features/auth/pages/signup_page1.dart';
import 'package:yatra/features/home/pages/home_page.dart';
import 'package:yatra/features/notification/pages/notification.dart';
import 'package:yatra/features/splash_screen/onboarding_page.dart';
import 'package:yatra/main.dart';

class RouteGenerator {
  static navigateToPage(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) {
    Navigator.push(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
    );
  }

  static navigateToPageWithoutStack(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
      (route) => false,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.notificationsRoute:
        NotificationsPayLoad? payLoad =
            settings.arguments as NotificationsPayLoad;
        return MaterialPageRoute(
          builder: (_) => Notifications(notificationsPayLoad: payLoad),
        );

      case Routes.signupPage1Route:
        final user = settings.arguments as AppUser;
        return MaterialPageRoute(builder: (_) => SignupPage1(user: user));

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());

      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingPage());

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case Routes.signupPageRoute:
        return MaterialPageRoute(builder: (_) => SignupPage());

      case Routes.placeListRoute:
        return MaterialPageRoute(builder: (_) => PlacesListScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
