import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './movie_search_card_widget.dart';

class SearchResultsWidget extends StatelessWidget {
  final bool isLoading;
  final List<Map<String, dynamic>> results;
  final bool hasSearched;
  final String query;
  final Function(Map<String, dynamic>) onMovieTap;
  final Future<void> Function() onRefresh;

  const SearchResultsWidget({
    Key? key,
    required this.isLoading,
    required this.results,
    required this.hasSearched,
    required this.query,
    required this.onMovieTap,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (hasSearched && results.isEmpty) {
      return _buildEmptyResultsState();
    }

    if (results.isNotEmpty) {
      return _buildResultsList();
    }

    return const SizedBox.shrink();
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      itemCount: 6,
      itemBuilder: (context, index) {
        return _buildSkeletonCard();
      },
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Skeleton poster
          Container(
            width: 20.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: AppTheme.dividerColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          SizedBox(width: 3.w),

          // Skeleton content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: AppTheme.dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  width: 30.w,
                  height: 1.5.h,
                  decoration: BoxDecoration(
                    color: AppTheme.dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  width: 25.w,
                  height: 1.5.h,
                  decoration: BoxDecoration(
                    color: AppTheme.dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'movie_filter',
            color: AppTheme.textSecondary,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            'No results found',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try searching for "$query" with different keywords',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textDisabledDark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton.icon(
            onPressed: () => onRefresh(),
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: AppTheme.textPrimary,
              size: 20,
            ),
            label: Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
              foregroundColor: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppTheme.accentColor,
      backgroundColor: AppTheme.secondaryDark,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        itemCount: results.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildResultsHeader();
          }

          final movie = results[index - 1];
          return MovieSearchCardWidget(
            movie: movie,
            onTap: () => onMovieTap(movie),
          );
        },
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${results.length} result${results.length == 1 ? '' : 's'} for "$query"',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          if (results.length > 1)
            TextButton.icon(
              onPressed: () {
                // Sort functionality can be added here
              },
              icon: CustomIconWidget(
                iconName: 'sort',
                color: AppTheme.accentColor,
                size: 16,
              ),
              label: Text(
                'Sort',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.accentColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
