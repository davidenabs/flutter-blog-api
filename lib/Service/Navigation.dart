import 'package:flutter/material.dart';
import 'package:todo_api/constants.dart';

class NavigationService {

  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget n) {
    return navigationKey.currentState!.push(MaterialPageRoute(builder: (context) => n));
  }

  back() {
    return navigationKey.currentState!.pop();
  }

  loader() {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: navigationKey.currentContext!,
          barrierDismissible: false,
          builder: (_) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          });
    });
  }



}