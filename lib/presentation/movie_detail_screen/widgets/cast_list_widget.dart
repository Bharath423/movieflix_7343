import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CastListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cast;

  const CastListWidget({
    Key? key,
    required this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Cast',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 1.5.h),
        SizedBox(
          height: 25.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: cast.length,
            itemBuilder: (context, index) {
              final actor = cast[index];
              return _buildCastCard(actor);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCastCard(Map<String, dynamic> actor) {
    return Container(
      width: 25.w,
      margin: EdgeInsets.only(right: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Actor profile image
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowDark,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl: actor["profile_url"] as String,
                width: 20.w,
                height: 20.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Actor name
          Text(
            actor["name"] as String,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 0.5.h),

          // Character name
          Text(
            actor["character"] as String,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
