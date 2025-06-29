import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants.dart';
import '../../core/models/user_model.dart';
import '../../shared/widgets/custom_app_bar.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;
        final contentPadding = isDesktop ? EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.2) : isTablet ? EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1) : EdgeInsets.all(16.w);
        return Scaffold(
          backgroundColor: AppColors.grey50,
          appBar: ResponsiveAppBar(
            title: user.name,
          ),
          body: SingleChildScrollView(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Profile Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isDesktop ? 40.w : isTablet ? 28.w : 20.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyWithOpacity,
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: isDesktop ? 120.w : isTablet ? 100.w : 80.w,
                        height: isDesktop ? 120.w : isTablet ? 100.w : 80.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryWithOpacity,
                          borderRadius: BorderRadius.circular(60.r),
                        ),
                        child: Center(
                          child: Text(
                            user.name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              fontSize: isDesktop ? 48.sp : isTablet ? 40.sp : 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: isDesktop ? 32.h : isTablet ? 24.h : 16.h),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: isDesktop ? 28.sp : isTablet ? 22.sp : 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '@${user.username}',
                        style: TextStyle(
                          fontSize: isDesktop ? 18.sp : isTablet ? 16.sp : 14.sp,
                          color: AppColors.grey600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: isDesktop ? 32.h : isTablet ? 24.h : 20.h),
                
                // Contact Information
                _buildSectionCard(
                  'Contact Information',
                  [
                    _buildInfoRow(Icons.email, 'Email', user.email),
                    if (user.phone != null) _buildInfoRow(Icons.phone, 'Phone', user.phone!),
                    if (user.website != null) _buildInfoRow(Icons.web, 'Website', user.website!),
                  ],
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
                
                SizedBox(height: isDesktop ? 24.h : isTablet ? 20.h : 16.h),
                
                // Address Information
                if (user.address != null) ...[
                  _buildSectionCard(
                    'Address',
                    [
                      _buildInfoRow(Icons.location_on, 'Street', '${user.address!.street}, ${user.address!.suite}'),
                      _buildInfoRow(Icons.location_city, 'City', user.address!.city),
                      _buildInfoRow(Icons.mail, 'Zipcode', user.address!.zipcode),
                      _buildInfoRow(Icons.place, 'Coordinates', '${user.address!.geo.lat}, ${user.address!.geo.lng}'),
                    ],
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isDesktop ? 24.h : isTablet ? 20.h : 16.h),
                ],
                
                // Company Information
                if (user.company != null) ...[
                  _buildSectionCard(
                    'Company',
                    [
                      _buildInfoRow(Icons.business, 'Name', user.company!.name),
                      _buildInfoRow(Icons.lightbulb, 'Catch Phrase', user.company!.catchPhrase),
                      _buildInfoRow(Icons.work, 'Business', user.company!.bs),
                    ],
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isDesktop ? 24.h : isTablet ? 20.h : 16.h),
                ],
                
                SizedBox(height: isDesktop ? 32.h : isTablet ? 24.h : 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children, {bool isDesktop = false, bool isTablet = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 32.w : isTablet ? 24.w : 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyWithOpacity,
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isDesktop ? 24.sp : isTablet ? 20.sp : 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: isDesktop ? 20.h : isTablet ? 16.h : 12.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: AppColors.primary,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
