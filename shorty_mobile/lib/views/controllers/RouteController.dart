import 'package:flutter/material.dart';
import 'package:shorty/views/screens/User/UserProfilePage.dart';
import 'package:shorty/views/screens/Shared/HomePage.dart';
import 'package:shorty/views/screens/Shared/LoginPage.dart';
import 'package:shorty/views/screens/Shared/RegisterPage.dart';
import 'package:shorty/views/screens/SplashPage.dart';
import 'package:shorty/views/screens/Admin/AdminAnalysisPage.dart';
import 'package:shorty/views/screens/WelcomePage.dart';
import 'package:shorty/views/util/ViewConstants.dart';
import 'package:shorty/views/widgets/InnerDrawerWithScreen.dart';
import 'package:shorty/views/screens/Shared/AnonymousPage.dart';


class RouteController {
  // ignore: missing_return
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ViewConstants.splashRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SplashPage(),
        );
        break;
      case ViewConstants.welcomeRoute:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 1666),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return WelcomePage();
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            var curve = Curves.linearToEaseOut;

            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
        break;
      case ViewConstants.loginRoute:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return LoginPage();
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
        break;
      case ViewConstants.registerRoute:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return RegisterPage();
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            var curve = Curves.linearToEaseOut;

            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
        break;
      case ViewConstants.homeRoute:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return InnerDrawerWithScreen(scaffoldArea: HomePage());
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            var curve = Curves.linearToEaseOut;

            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
        break;
      case ViewConstants.anonymousRoute:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return AnonymousPage();
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            var curve = Curves.linearToEaseOut;

            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
        break;
      case ViewConstants.userProfileRoute:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return InnerDrawerWithScreen(scaffoldArea: UserProfilePage());
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            var curve = Curves.linearToEaseOut;

            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
        break;
      case ViewConstants.adminProfileRoute:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return InnerDrawerWithScreen(scaffoldArea: AdminAnalysisPage());
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            var curve = Curves.linearToEaseOut;

            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
        break;
    }
  }
}
