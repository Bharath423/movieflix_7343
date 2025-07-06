import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final List<String> selectedGenres;
  final int? selectedYear;
  final double? minRating;
  final Function(List<String>, int?, double?) onFiltersApplied;

  const FilterBottomSheetWidget({
    Key? key,
    required this.selectedGenres,
    required this.selectedYear,
    required this.minRating,
    required this.onFiltersApplied,
  }) : super(key: key);

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late List<String> _selectedGenres;
  late int? _selectedYear;
  late double? _minRating;

  final List<String> _availableGenres = [
    'Action',
    'Adventure',
    'Comedy',
    'Crime',
    'Drama',
    'Fantasy',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Thriller',
    'Animation',
    'Documentary',
  ];

  final List<int> _availableYears = List.generate(
    DateTime.now().year - 1950 + 1,
    (index) => DateTime.now().year - index,
  );

  @override
  void initState() {
    super.initState();
    _selectedGenres = List.from(widget.selectedGenres);
    _selectedYear = widget.selectedYear;
    _minRating = widget.minRating;
  }

  @override
  Widget build(BuildContext context) {
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
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 1.h),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Movies',
                  style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: _clearAllFilters,
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

          // Filters content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGenresSection(),
                  SizedBox(height: 3.h),
                  _buildYearSection(),
                  SizedBox(height: 3.h),
                  _buildRatingSection(),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),

          // Apply button
          Container(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: AppTheme.textPrimary,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
                child: Text(
                  'Apply Filters',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genres',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _availableGenres.map((genre) {
            final bool isSelected = _selectedGenres.contains(genre);
            return FilterChip(
              label: Text(genre),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedGenres.add(genre);
                  } else {
                    _selectedGenres.remove(genre);
                  }
                });
              },
              backgroundColor: AppTheme.secondaryDark,
              selectedColor: AppTheme.accentColor.withValues(alpha: 0.2),
              checkmarkColor: AppTheme.accentColor,
              labelStyle: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppTheme.accentColor : AppTheme.textPrimary,
              ),
              side: BorderSide(
                color:
                    isSelected ? AppTheme.accentColor : AppTheme.dividerColor,
                width: 1,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildYearSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Release Year',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.secondaryDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.dividerColor,
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int?>(
              value: _selectedYear,
              hint: Text(
                'Select Year',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              dropdownColor: AppTheme.secondaryDark,
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
              icon: CustomIconWidget(
                iconName: 'arrow_drop_down',
                color: AppTheme.textSecondary,
                size: 24,
              ),
              items: [
                DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Any Year'),
                ),
                ..._availableYears.take(20).map((year) {
                  return DropdownMenuItem<int?>(
                    value: year,
                    child: Text(year.toString()),
                  );
                }).toList(),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedYear = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minimum Rating',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              _minRating != null ? _minRating!.toStringAsFixed(1) : 'Any',
              style: AppTheme.dataTextStyle(
                fontSize: 14.sp,
                color: AppTheme.accentColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppTheme.accentColor,
            inactiveTrackColor: AppTheme.dividerColor,
            thumbColor: AppTheme.accentColor,
            overlayColor: AppTheme.accentColor.withValues(alpha: 0.2),
            valueIndicatorColor: AppTheme.accentColor,
            valueIndicatorTextStyle:
                AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          child: Slider(
            value: _minRating ?? 0.0,
            min: 0.0,
            max: 10.0,
            divisions: 20,
            label: _minRating?.toStringAsFixed(1) ?? '0.0',
            onChanged: (value) {
              setState(() {
                _minRating = value == 0.0 ? null : value;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0.0',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              '10.0',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _clearAllFilters() {
    setState(() {
      _selectedGenres.clear();
      _selectedYear = null;
      _minRating = null;
    });
  }

  void _applyFilters() {
    widget.onFiltersApplied(_selectedGenres, _selectedYear, _minRating);
    Navigator.pop(context);
  }
}
