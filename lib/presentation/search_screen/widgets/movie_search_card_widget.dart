import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MovieSearchCardWidget extends StatelessWidget {
  final Map<String, dynamic> movie;
  final VoidCallback onTap;

  const MovieSearchCardWidget({
    Key? key,
    required this.movie,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = movie["title"] ?? "Unknown Title";
    final String year = movie["year"] ?? "N/A";
    final double rating = (movie["rating"] ?? 0.0).toDouble();
    final String poster = movie["poster"] ?? "";
    final List<String> genres =
        movie["genres"] != null ? (movie["genres"] as List).cast<String>() : [];

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.secondaryDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.dividerColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster
                _buildMoviePoster(poster),

                SizedBox(width: 3.w),

                // Movie Details
                Expanded(
                  child: _buildMovieDetails(title, year, rating, genres),
                ),

                // Arrow Icon
                CustomIconWidget(
                  iconName: 'chevron_right',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoviePoster(String poster) {
    return Container(
      width: 20.w,
      height: 12.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppTheme.dividerColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: poster.isNotEmpty
            ? CustomImageWidget(
                imageUrl: poster,
                width: 20.w,
                height: 12.h,
                fit: BoxFit.cover,
              )
            : Center(
                child: CustomIconWidget(
                  iconName: 'movie',
                  color: AppTheme.textSecondary,
                  size: 24,
                ),
              ),
      ),
    );
  }

  Widget _buildMovieDetails(
      String title, String year, double rating, List<String> genres) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: 0.5.h),

        // Year and Rating Row
        Row(
          children: [
            Text(
              year,
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            if (rating > 0) ...[
              SizedBox(width: 2.w),
              Container(
                width: 1,
                height: 12,
                color: AppTheme.dividerColor,
              ),
              SizedBox(width: 2.w),
              CustomIconWidget(
                iconName: 'star',
                color: AppTheme.warningColor,
                size: 16,
              ),
              SizedBox(width: 1.w),
              Text(
                rating.toStringAsFixed(1),
                style: AppTheme.dataTextStyle(
                  fontSize: 12.sp,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ],
        ),

        SizedBox(height: 1.h),

        // Genres
        if (genres.isNotEmpty)
          Wrap(
            spacing: 1.w,
            runSpacing: 0.5.h,
            children: genres.take(2).map((genre) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.accentColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  genre,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.accentColor,
                    fontSize: 10.sp,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
