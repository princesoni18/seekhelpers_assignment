import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seekhelpers_assignment/features/home/home_screen.dart';
import 'package:seekhelpers_assignment/features/home/bloc/user_bloc.dart';
import 'package:seekhelpers_assignment/features/home/bloc/user_event.dart';
import 'package:seekhelpers_assignment/features/home/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine device type and set appropriate design size
        Size designSize;
        if (constraints.maxWidth >= 1024) {
          // Desktop
          designSize = const Size(1440, 900);
        } else if (constraints.maxWidth >= 600) {
          // Tablet
          designSize = const Size(834, 1194);
        } else {
          // Mobile
          designSize = const Size(375, 812);
        }
        
        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return BlocProvider(
              create: (context) => UserBloc(UserRepository())..add(FetchUsers()),
              child: MaterialApp(
                title: 'SeekHelpers Assignment',
                debugShowCheckedModeBanner: false,
                theme: _buildTheme(context),
                home: const HomeScreen(),
              ),
            );
          },
        );
      },
    );
  }
  
  ThemeData _buildTheme(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      // Adaptive app bar theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: isDesktop ? 80 : isTablet ? 70 : 56,
        titleTextStyle: TextStyle(
          fontSize: isDesktop ? 24 : isTablet ? 20 : 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      // Adaptive elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32 : isTablet ? 24 : 16,
            vertical: isDesktop ? 16 : isTablet ? 12 : 8,
          ),
          textStyle: TextStyle(
            fontSize: isDesktop ? 18 : isTablet ? 16 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Adaptive card theme
      cardTheme: CardTheme(
        elevation: 2,
        margin: EdgeInsets.symmetric(
          horizontal: isDesktop ? 24 : isTablet ? 16 : 8,
          vertical: isDesktop ? 12 : isTablet ? 8 : 4,
        ),
      ),
      // Adaptive list tile theme
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 32 : isTablet ? 24 : 16,
          vertical: isDesktop ? 16 : isTablet ? 12 : 8,
        ),
        titleTextStyle: TextStyle(
          fontSize: isDesktop ? 20 : isTablet ? 18 : 16,
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: isDesktop ? 16 : isTablet ? 14 : 12,
          color: Colors.grey[600],
        ),
      ),
      // Adaptive floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        iconSize: isDesktop ? 32 : isTablet ? 28 : 24,
        sizeConstraints: BoxConstraints(
          minWidth: isDesktop ? 72 : isTablet ? 64 : 56,
          minHeight: isDesktop ? 72 : isTablet ? 64 : 56,
        ),
      ),
    );
  }
}

