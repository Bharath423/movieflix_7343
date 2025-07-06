import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HeroPosterWidget extends StatelessWidget {
  final String backdropUrl;
  final String posterUrl;
  final String title;

  const HeroPosterWidget({
    Key? key,
    required this.backdropUrl,
    required this.posterUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      child: Stack(
        children: [
          // Backdrop image with parallax effect
          Positioned.fill(
            child: Hero(
              tag: 'movie_backdrop_$title',
              child: CustomImageWidget(
                imageUrl: backdropUrl,
                width: double.infinity,
                height: 50.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.darkTheme.scaffoldBackgroundColor
                        .withValues(alpha: 0.3),
                    AppTheme.darkTheme.scaffoldBackgroundColor
                        .withValues(alpha: 0.8),
                    AppTheme.darkTheme.scaffoldBackgroundColor,
                  ],
                  stops: const [0.0, 0.5, 0.8, 1.0],
                ),
              ),
            ),
          ),

          // Poster image positioned at bottom
          Positioned(
            bottom: -5.h,
            left: 4.w,
            child: Hero(
              tag: 'movie_poster_$title',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowDark,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomImageWidget(
                    imageUrl: posterUrl,
                    width: 30.w,
                    height: 20.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Tap detector for full-screen gallery
          Positioned.fill(
            child: GestureDetector(
              onLongPress: () => _showFullScreenGallery(context),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFullScreenGallery(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.textPrimary,
                    size: 24,
                  ),
                ),
              ),
              body: Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: const EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: CustomImageWidget(
                    imageUrl: posterUrl,
                    width: 90.w,
                    height: 70.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
