import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class MovieShimmerWidget extends StatefulWidget {
  const MovieShimmerWidget({Key? key}) : super(key: key);

  @override
  State<MovieShimmerWidget> createState() => _MovieShimmerWidgetState();
}

class _MovieShimmerWidgetState extends State<MovieShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildShimmerContainer({
    required double width,
    required double height,
    double borderRadius = 8,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppTheme.secondaryDark.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Container(
        decoration: AppTheme.elevatedCardDecoration(
          backgroundColor: AppTheme.cardDark,
          borderRadius: 16,
          elevation: 1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer Poster
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _buildShimmerContainer(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 0,
                ),
              ),
            ),
            // Shimmer Content
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  _buildShimmerContainer(
                    width: 70.w,
                    height: 2.h,
                    borderRadius: 4,
                  ),
                  SizedBox(height: 1.h),
                  _buildShimmerContainer(
                    width: 50.w,
                    height: 1.5.h,
                    borderRadius: 4,
                  ),
                  SizedBox(height: 2.h),
                  // Date shimmer
                  Row(
                    children: [
                      _buildShimmerContainer(
                        width: 4.w,
                        height: 4.w,
                        borderRadius: 2,
                      ),
                      SizedBox(width: 2.w),
                      _buildShimmerContainer(
                        width: 25.w,
                        height: 1.5.h,
                        borderRadius: 4,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  // Overview shimmer lines
                  _buildShimmerContainer(
                    width: double.infinity,
                    height: 1.2.h,
                    borderRadius: 4,
                  ),
                  SizedBox(height: 0.8.h),
                  _buildShimmerContainer(
                    width: double.infinity,
                    height: 1.2.h,
                    borderRadius: 4,
                  ),
                  SizedBox(height: 0.8.h),
                  _buildShimmerContainer(
                    width: 60.w,
                    height: 1.2.h,
                    borderRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
