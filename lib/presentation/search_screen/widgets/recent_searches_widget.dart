import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentSearchesWidget extends StatelessWidget {
  final List<String> recentSearches;
  final Function(String) onSearchTap;
  final Function(String) onRemove;

  const RecentSearchesWidget({
    Key? key,
    required this.recentSearches,
    required this.onSearchTap,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return recentSearches.isEmpty
        ? _buildEmptyState()
        : _buildRecentSearchesList();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search',
            color: AppTheme.textSecondary,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            'Start typing to search',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Discover your favorite movies',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textDisabledDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearchesList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searches',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                if (recentSearches.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      for (String search in List.from(recentSearches)) {
                        onRemove(search);
                      }
                    },
                    child: Text(
                      'Clear All',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Recent searches chips
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: recentSearches.map((search) {
                return _buildSearchChip(search);
              }).toList(),
            ),
          ),

          SizedBox(height: 4.h),

          // Popular searches section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Popular Searches',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          ),

          SizedBox(height: 2.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: [
                'Marvel',
                'DC',
                'Action',
                'Comedy',
                'Horror',
                'Sci-Fi',
                'Romance',
                'Thriller'
              ].map((search) {
                return _buildPopularSearchChip(search);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchChip(String search) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onSearchTap(search),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'history',
                color: AppTheme.textSecondary,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                search,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              SizedBox(width: 2.w),
              GestureDetector(
                onTap: () => onRemove(search),
                child: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.textSecondary,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularSearchChip(String search) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.accentColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onSearchTap(search),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'trending_up',
                color: AppTheme.accentColor,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                search,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
