import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MovieCardWidget extends StatelessWidget {
  final Map<String, dynamic> movie;
  final VoidCallback onTap;

  const MovieCardWidget({
    Key? key,
    required this.movie,
    required this.onTap,
  }) : super(key: key);

  String _formatReleaseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Unknown';

    try {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _formatRating(dynamic rating) {
    if (rating == null) return '0.0';
    if (rating is num) {
      return rating.toStringAsFixed(1);
    }
    return rating.toString();
  }

  @override
  Widget build(BuildContext context) {
    final title = (movie['title'] as String?) ?? 'Unknown Title';
    final overview = (movie['overview'] as String?) ?? '';
    final posterPath = movie['poster_path'] as String?;
    final releaseDate = movie['release_date'] as String?;
    final voteAverage = movie['vote_average'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: AppTheme.elevatedCardDecoration(
              backgroundColor: AppTheme.cardDark,
              borderRadius: 16,
              elevation: 3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster with Rating Overlay
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: posterPath != null && posterPath.isNotEmpty
                            ? CustomImageWidget(
                                imageUrl: posterPath,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: AppTheme.secondaryDark,
                                child: Center(
                                  child: CustomIconWidget(
                                    iconName: 'movie',
                                    color: AppTheme.textSecondary,
                                    size: 12.w,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    // Rating Badge
                    Positioned(
                      top: 2.w,
                      right: 2.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryDark.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.accentColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'star',
                              color: AppTheme.warningColor,
                              size: 3.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              _formatRating(voteAverage),
                              style: AppTheme.dataTextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Movie Information
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        title,
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),
                      // Release Date
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'calendar_today',
                            color: AppTheme.textSecondary,
                            size: 3.5.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            _formatReleaseDate(releaseDate),
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.5.h),
                      // Overview
                      if (overview.isNotEmpty)
                        Text(
                          overview,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
