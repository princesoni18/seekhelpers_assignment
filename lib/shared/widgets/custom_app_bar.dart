import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_navigator.dart';
import '../../core/utils/responsive_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool centerTitle;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: context.adaptiveFontSize(mobile: 18, tablet: 22, desktop: 28),
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
      leading: leading ?? (automaticallyImplyLeading && AppNavigator.canPop(context)
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: context.adaptiveIconSize(mobile: 20, tablet: 24, desktop: 28),
              ),
              onPressed: onBackPressed ?? () => AppNavigator.pop(context),
            )
          : null),
      automaticallyImplyLeading: false, // We handle this manually
      backgroundColor: backgroundColor ?? Colors.deepPurple,
      foregroundColor: foregroundColor ?? Colors.white,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight.h);
  }
}

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBackPressed;

  const ResponsiveAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: title,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      onBackPressed: onBackPressed,
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight.h);
  }
}
