import 'package:flutter/cupertino.dart';

// Define the NavigationService class
class NavigationService {
  // Create a GlobalKey of NavigatorState. This allows you to control the
  // Navigator from outside of the widget tree.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // The navigateTo method takes a route name and navigates to it.
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  // The goBack method pops the topmost route off the navigation stack,
  // effectively navigating back to the previous page.
  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
