import 'package:flutter/material.dart';
import 'package:yatra/core/utils/routes.dart';
import 'package:yatra/features/auth/model/user.dart';
import 'package:yatra/features/auth/pages/signup_page1.dart';
import 'package:yatra/features/notification/pages/notification.dart';
import 'package:yatra/main.dart';

class RouteGenerator {
  static navigateToPage(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.push(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
    );
  }

  static navigateToPageWithoutStack(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.pushAndRemoveUntil(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
      (route) => false,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.notificationsRoute:
      NotificationsPayLoad ? payLoad=settings.arguments as NotificationsPayLoad;
        return MaterialPageRoute(builder: (_) =>  Notifications(notificationsPayLoad: payLoad));
        
case Routes.signupPage1Route:
      final user = settings.arguments as AppUser;
      return MaterialPageRoute(
        builder: (_) => SignupPage1(user: user),
      );

        default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}