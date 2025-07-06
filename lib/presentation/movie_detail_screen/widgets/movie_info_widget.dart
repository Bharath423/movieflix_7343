import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MovieInfoWidget extends StatelessWidget {
  final String title;
  final String releaseDate;
  final int runtime;
  final double rating;
  final int voteCount;

  const MovieInfoWidget({
    Key? key,
    required this.title,
    required this.releaseDate,
    required this.runtime,
    required this.rating,
    required this.voteCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie title
          Text(
            title,
            style: AppTheme.darkTheme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 2.h),

          // Movie details row
          Wrap(
            spacing: 4.w,
            runSpacing: 1.h,
            children: [
              _buildInfoChip(
                icon: 'calendar_today',
                text: _formatReleaseDate(releaseDate),
              ),
              _buildInfoChip(
                icon: 'access_time',
                text: _formatRuntime(runtime),
              ),
              _buildRatingChip(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required String icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: icon,
            color: AppTheme.textSecondary,
            size: 16,
          ),
          SizedBox(width: 2.w),
          Text(
            text,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.accentColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: 'star',
            color: AppTheme.accentColor,
            size: 16,
          ),
          SizedBox(width: 2.w),
          Text(
            rating.toStringAsFixed(1),
            style: AppTheme.dataTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.accentColor,
            ),
          ),
          SizedBox(width: 1.w),
          Text(
            '(${_formatVoteCount(voteCount)})',
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  String _formatReleaseDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _formatRuntime(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return hours > 0
        ? '${hours}h ${remainingMinutes}m'
        : '${remainingMinutes}m';
  }

  String _formatVoteCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
