import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TechnicalSpecsWidget extends StatefulWidget {
  final Map<String, dynamic> specs;

  const TechnicalSpecsWidget({
    Key? key,
    required this.specs,
  }) : super(key: key);

  @override
  State<TechnicalSpecsWidget> createState() => _TechnicalSpecsWidgetState();
}

class _TechnicalSpecsWidgetState extends State<TechnicalSpecsWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        decoration: AppTheme.elevatedCardDecoration(
          borderRadius: 16,
          elevation: 2,
        ),
        child: Column(
          children: [
            // Header
            InkWell(
              onTap: _toggleExpansion,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Container(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'info_outline',
                      color: AppTheme.accentColor,
                      size: 24,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        'Technical Specifications',
                        style:
                            AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: CustomIconWidget(
                        iconName: 'keyboard_arrow_down',
                        color: AppTheme.textSecondary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expandable content
            SizeTransition(
              sizeFactor: _expandAnimation,
              child: Container(
                padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                child: Column(
                  children: [
                    Divider(
                      color: AppTheme.dividerColor,
                      thickness: 1,
                    ),
                    SizedBox(height: 2.h),
                    _buildSpecsGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecsGrid() {
    final List<MapEntry<String, dynamic>> specEntries =
        widget.specs.entries.toList();

    return Column(
      children: [
        for (int i = 0; i < specEntries.length; i += 2)
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Row(
              children: [
                Expanded(
                  child: _buildSpecItem(
                    specEntries[i].key,
                    specEntries[i].value,
                  ),
                ),
                if (i + 1 < specEntries.length) ...[
                  SizedBox(width: 4.w),
                  Expanded(
                    child: _buildSpecItem(
                      specEntries[i + 1].key,
                      specEntries[i + 1].value,
                    ),
                  ),
                ] else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSpecItem(String key, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formatSpecKey(key),
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          _formatSpecValue(value),
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _formatSpecKey(String key) {
    return key
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatSpecValue(dynamic value) {
    if (value is List) {
      return (value).join(', ');
    }
    return value.toString();
  }
}
