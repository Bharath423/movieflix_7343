import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FavoritesSortBottomSheet extends StatelessWidget {
  final String currentSortOption;
  final Function(String) onSortChanged;

  const FavoritesSortBottomSheet({
    super.key,
    required this.currentSortOption,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sortOptions = [
      {
        'title': 'Date Added',
        'subtitle': 'Recently added first',
        'icon': 'schedule',
      },
      {
        'title': 'Title',
        'subtitle': 'Alphabetical order',
        'icon': 'sort_by_alpha',
      },
      {
        'title': 'Release Date',
        'subtitle': 'Newest movies first',
        'icon': 'calendar_today',
      },
      {
        'title': 'Personal Rating',
        'subtitle': 'Highest rated first',
        'icon': 'star',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.dialogDark,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Text(
                  'Sort by',
                  style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.textSecondary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Sort Options
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortOptions.length,
            itemBuilder: (context, index) {
              final option = sortOptions[index];
              final isSelected = currentSortOption == option['title'];

              return ListTile(
                leading: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.accentColor.withValues(alpha: 0.2)
                        : AppTheme.secondaryDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: option['icon'] as String,
                    color: isSelected
                        ? AppTheme.accentColor
                        : AppTheme.textSecondary,
                    size: 20,
                  ),
                ),
                title: Text(
                  option['title'] as String,
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? AppTheme.accentColor
                        : AppTheme.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  option['subtitle'] as String,
                  style: AppTheme.darkTheme.textTheme.bodySmall,
                ),
                trailing: isSelected
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.accentColor,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  onSortChanged(option['title'] as String);
                  Navigator.of(context).pop();
                },
              );
            },
          ),

          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
