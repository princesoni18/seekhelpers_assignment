import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppNavigator {
  /// Navigate to a new screen with fade transition
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.push<T>(
      context,
      PageTransition<T>(
        type: PageTransitionType.fade,
        child: page,
        duration: duration,
      ),
    );
  }

  /// Replace current screen with fade transition
  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    TO? result,
  }) {
    return Navigator.pushReplacement<T, TO>(
      context,
      PageTransition<T>(
        type: PageTransitionType.fade,
        child: page,
        duration: duration,
      ),
      result: result,
    );
  }

  /// Push and remove all previous routes with fade transition
  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget page,
    RoutePredicate predicate, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      PageTransition<T>(
        type: PageTransitionType.fade,
        child: page,
        duration: duration,
      ),
      predicate,
    );
  }

  /// Pop current screen
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  /// Pop until a specific route
  static void popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.popUntil(context, predicate);
  }

  /// Check if can pop
  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  /// Pop to root (remove all routes except first)
  static void popToRoot(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
