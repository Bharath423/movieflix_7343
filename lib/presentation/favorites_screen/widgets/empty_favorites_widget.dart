import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  final VoidCallback onBrowseMovies;

  const EmptyFavoritesWidget({
    super.key,
    required this.onBrowseMovies,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty State Illustration
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'favorite_border',
                color: AppTheme.textSecondary,
                size: 80,
              ),
            ),

            SizedBox(height: 4.h),

            // Title
            Text(
              'No Favorites Yet',
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 2.h),

            // Description
            Text(
              'Start building your movie collection by adding your favorite films. Tap the heart icon on any movie to save it here.',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 4.h),

            // Browse Movies Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onBrowseMovies,
                icon: CustomIconWidget(
                  iconName: 'movie',
                  color: AppTheme.textPrimary,
                  size: 20,
                ),
                label: const Text('Browse Movies'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: AppTheme.textPrimary,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Secondary Action
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/search-screen');
              },
              icon: CustomIconWidget(
                iconName: 'search',
                color: AppTheme.accentColor,
                size: 18,
              ),
              label: const Text('Search Movies'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.accentColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 1.5.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
