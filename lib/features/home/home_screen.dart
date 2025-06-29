import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants.dart';
import '../../core/utils/app_navigator.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';
import '../user_details/user_detail_screen.dart';
import '../add_user/add_user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;
        final listPadding = isDesktop ? EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.2) : isTablet ? EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1) : EdgeInsets.symmetric(horizontal: 16.w);
        return Scaffold(
          backgroundColor: AppColors.grey50,
          appBar:const  ResponsiveAppBar(
            title: 'Users Directory',
            automaticallyImplyLeading: false, // Home screen doesn't need back button
          ),
          body: Column(
            children: [
              Container(
                padding: isDesktop ? EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.2, vertical: 24.h) : isTablet ? EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1, vertical: 20.h) : EdgeInsets.all(16.w),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    hintStyle: TextStyle(
                      fontSize: isDesktop ? 18.sp : isTablet ? 16.sp : 14.sp,
                      color: AppColors.grey600,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.grey600,
                      size: isDesktop ? 28.sp : isTablet ? 24.sp : 20.sp,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  onChanged: (query) {
                    context.read<UserBloc>().add(SearchUsers(query));
                  },
                ),
              ),
              SizedBox(height: isDesktop ? 32.h : isTablet ? 24.h : 16.h),
              Expanded(
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserLoaded) {
                      if (state.users.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_search,
                                size: isDesktop ? 96.sp : isTablet ? 80.sp : 64.sp,
                                color: AppColors.grey400,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'No users found',
                                style: TextStyle(
                                  fontSize: isDesktop ? 22.sp : isTablet ? 18.sp : 16.sp,
                                  color: AppColors.grey600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: listPadding,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: isDesktop ? 24.h : isTablet ? 18.h : 12.h),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.greyWithOpacity,
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: isDesktop ? 32.w : isTablet ? 24.w : 16.w,
                                vertical: isDesktop ? 16.h : isTablet ? 12.h : 8.h,
                              ),
                              leading: Container(
                                width: isDesktop ? 56.w : isTablet ? 48.w : 40.w,
                                height: isDesktop ? 56.w : isTablet ? 48.w : 40.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryWithOpacity,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Center(
                                  child: Text(
                                    '${user.id}',
                                    style: TextStyle(
                                      fontSize: isDesktop ? 22.sp : isTablet ? 18.sp : 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                user.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: isDesktop ? 22.sp : isTablet ? 18.sp : 16.sp,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                              subtitle: Text(
                                user.email,
                                style: TextStyle(
                                  fontSize: isDesktop ? 16.sp : isTablet ? 14.sp : 12.sp,
                                  color: AppColors.grey600,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: isDesktop ? 24.sp : isTablet ? 20.sp : 16.sp,
                                color: AppColors.grey400,
                              ),
                              onTap: () {
                                AppNavigator.push(
                                  context,
                                  UserDetailScreen(user: user),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is UserError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: isDesktop ? 96.sp : isTablet ? 80.sp : 64.sp,
                              color: AppColors.red400,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.message,
                              style: TextStyle(
                                fontSize: isDesktop ? 22.sp : isTablet ? 18.sp : 16.sp,
                                color: AppColors.red600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppNavigator.push(
                context,
                const AddUserScreen(),
              );
            },
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            child: Icon(Icons.add, size: isDesktop ? 32.sp : isTablet ? 28.sp : 24.sp),
          ),
        );
      },
    );
  }
}
