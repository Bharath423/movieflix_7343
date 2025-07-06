import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PlotSynopsisWidget extends StatefulWidget {
  final String plot;

  const PlotSynopsisWidget({
    Key? key,
    required this.plot,
  }) : super(key: key);

  @override
  State<PlotSynopsisWidget> createState() => _PlotSynopsisWidgetState();
}

class _PlotSynopsisWidgetState extends State<PlotSynopsisWidget> {
  bool _isExpanded = false;
  static const int _maxLines = 4;

  @override
  Widget build(BuildContext context) {
    final bool isLongText = widget.plot.length > 200;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Plot Synopsis',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.5.h),
          AnimatedCrossFade(
            firstChild: _buildCollapsedText(),
            secondChild: _buildExpandedText(),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          if (isLongText) ...[
            SizedBox(height: 1.h),
            _buildReadMoreButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildCollapsedText() {
    return Text(
      widget.plot,
      style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
        height: 1.6,
        color: AppTheme.textSecondary,
      ),
      maxLines: _maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildExpandedText() {
    return Text(
      widget.plot,
      style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
        height: 1.6,
        color: AppTheme.textSecondary,
      ),
    );
  }

  Widget _buildReadMoreButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isExpanded ? 'Read Less' : 'Read More',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 1.w),
            AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: CustomIconWidget(
                iconName: 'keyboard_arrow_down',
                color: AppTheme.accentColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
