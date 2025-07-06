import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FavoriteMovieCardWidget extends StatelessWidget {
  final Map<String, dynamic> movie;
  final bool isMultiSelectMode;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onRemove;

  const FavoriteMovieCardWidget({
    super.key,
    required this.movie,
    required this.isMultiSelectMode,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    required this.onRemove,
  });

  String _formatDate(String dateString) {
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

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('movie_${movie['id']}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 4.w),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'delete',
              color: AppTheme.textPrimary,
              size: 24,
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Remove',
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Remove from Favorites',
                style: AppTheme.darkTheme.textTheme.titleLarge,
              ),
              content: Text(
                'Are you sure you want to remove "${movie['title']}" from your favorites?',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Remove'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) => onRemove(),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.accentColor.withValues(alpha: 0.1)
                : AppTheme.cardDark,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: AppTheme.accentColor, width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadowDark,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Movie Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomImageWidget(
                  imageUrl: movie['posterUrl'] as String,
                  width: 20.w,
                  height: 12.h,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 3.w),

              // Movie Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      movie['title'] as String,
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
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
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          _formatDate(movie['releaseDate'] as String),
                          style: AppTheme.darkTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),

                    SizedBox(height: 0.5.h),

                    // Date Added
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'favorite',
                          color: AppTheme.accentColor,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Added ${_formatDate(movie['dateAdded'] as String)}',
                          style: AppTheme.darkTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),

                    SizedBox(height: 0.5.h),

                    // Personal Rating
                    if (movie['personalRating'] != null)
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'star',
                            color: AppTheme.warningColor,
                            size: 14,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${movie['personalRating']}/10',
                            style: AppTheme.dataTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.warningColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // Selection Checkbox or Arrow
              if (isMultiSelectMode)
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isSelected ? AppTheme.accentColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.accentColor
                          : AppTheme.textSecondary,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: AppTheme.textPrimary,
                          size: 16,
                        )
                      : null,
                )
              else
                CustomIconWidget(
                  iconName: 'chevron_right',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
