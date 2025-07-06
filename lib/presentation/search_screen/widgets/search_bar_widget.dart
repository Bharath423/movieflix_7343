import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final Function(String) onSubmitted;

  const SearchBarWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = widget.controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.focusNode.hasFocus
                ? AppTheme.accentColor
                : AppTheme.dividerColor,
            width: widget.focusNode.hasFocus ? 2 : 1,
          ),
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: AppTheme.darkTheme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            hintStyle: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textDisabledDark,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'search',
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
            suffixIcon: _hasText
                ? IconButton(
                    onPressed: widget.onClear,
                    icon: CustomIconWidget(
                      iconName: 'clear',
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 2.h,
            ),
          ),
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            widget.onChanged(value);
          },
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}
