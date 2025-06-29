import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Adaptive padding based on device type
  static EdgeInsets getAdaptivePadding(BuildContext context, {
    double mobile = 16,
    double tablet = 24,
    double desktop = 32,
  }) {
    if (isDesktop(context)) {
      return EdgeInsets.all(desktop.w);
    } else if (isTablet(context)) {
      return EdgeInsets.all(tablet.w);
    } else {
      return EdgeInsets.all(mobile.w);
    }
  }

  // Adaptive horizontal padding for content
  static EdgeInsets getContentPadding(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    if (isDesktop(context)) {
      return EdgeInsets.symmetric(horizontal: screenWidth * 0.15);
    } else if (isTablet(context)) {
      return EdgeInsets.symmetric(horizontal: screenWidth * 0.08);
    } else {
      return EdgeInsets.symmetric(horizontal: 16.w);
    }
  }

  // Adaptive font size
  static double getAdaptiveFontSize(BuildContext context, {
    double mobile = 14,
    double tablet = 16,
    double desktop = 18,
  }) {
    if (isDesktop(context)) {
      return desktop.sp;
    } else if (isTablet(context)) {
      return tablet.sp;
    } else {
      return mobile.sp;
    }
  }

  // Adaptive icon size
  static double getAdaptiveIconSize(BuildContext context, {
    double mobile = 24,
    double tablet = 28,
    double desktop = 32,
  }) {
    if (isDesktop(context)) {
      return desktop.sp;
    } else if (isTablet(context)) {
      return tablet.sp;
    } else {
      return mobile.sp;
    }
  }

  // Get number of columns for grid layouts
  static int getGridColumns(BuildContext context) {
    if (isDesktop(context)) {
      return 3;
    } else if (isTablet(context)) {
      return 2;
    } else {
      return 1;
    }
  }

  // Adaptive spacing
  static double getAdaptiveSpacing(BuildContext context, {
    double mobile = 8,
    double tablet = 12,
    double desktop = 16,
  }) {
    if (isDesktop(context)) {
      return desktop.h;
    } else if (isTablet(context)) {
      return tablet.h;
    } else {
      return mobile.h;
    }
  }

  // Get adaptive card width for forms and content
  static double getCardWidth(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    if (isDesktop(context)) {
      return screenWidth * 0.4; // 40% of screen width
    } else if (isTablet(context)) {
      return screenWidth * 0.7; // 70% of screen width
    } else {
      return screenWidth - 32.w; // Full width minus padding
    }
  }

  // Adaptive list tile height
  static double getListTileHeight(BuildContext context) {
    if (isDesktop(context)) {
      return 80.h;
    } else if (isTablet(context)) {
      return 70.h;
    } else {
      return 60.h;
    }
  }
}

// Extension to make responsive calls easier
extension ResponsiveContext on BuildContext {
  bool get isMobile => ResponsiveHelper.isMobile(this);
  bool get isTablet => ResponsiveHelper.isTablet(this);
  bool get isDesktop => ResponsiveHelper.isDesktop(this);
  
  double get screenWidth => ResponsiveHelper.getScreenWidth(this);
  double get screenHeight => ResponsiveHelper.getScreenHeight(this);
  
  EdgeInsets adaptivePadding({double mobile = 16, double tablet = 24, double desktop = 32}) =>
      ResponsiveHelper.getAdaptivePadding(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  EdgeInsets get contentPadding => ResponsiveHelper.getContentPadding(this);
  
  double adaptiveFontSize({double mobile = 14, double tablet = 16, double desktop = 18}) =>
      ResponsiveHelper.getAdaptiveFontSize(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  double adaptiveIconSize({double mobile = 24, double tablet = 28, double desktop = 32}) =>
      ResponsiveHelper.getAdaptiveIconSize(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  int get gridColumns => ResponsiveHelper.getGridColumns(this);
  
  double adaptiveSpacing({double mobile = 8, double tablet = 12, double desktop = 16}) =>
      ResponsiveHelper.getAdaptiveSpacing(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  double get cardWidth => ResponsiveHelper.getCardWidth(this);
  
  double get listTileHeight => ResponsiveHelper.getListTileHeight(this);
}
