import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _fadeAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _showRetryButton = false;
  bool _isInitializing = true;
  String _statusMessage = "Initializing MovieFlix...";

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoAnimationController.forward();
    _fadeAnimationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      setState(() {
        _statusMessage = "Connecting to TMDB API...";
      });

      // Simulate API connectivity check
      await Future.delayed(const Duration(milliseconds: 800));

      setState(() {
        _statusMessage = "Loading movie data...";
      });

      // Simulate loading cached data
      await Future.delayed(const Duration(milliseconds: 600));

      setState(() {
        _statusMessage = "Preparing image services...";
      });

      // Simulate image loading service setup
      await Future.delayed(const Duration(milliseconds: 400));

      setState(() {
        _statusMessage = "Ready to explore movies!";
      });

      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/movie-list-screen');
      }
    } catch (e) {
      setState(() {
        _isInitializing = false;
        _showRetryButton = true;
        _statusMessage = "Failed to initialize. Please try again.";
      });
    }
  }

  void _retryInitialization() {
    setState(() {
      _isInitializing = true;
      _showRetryButton = false;
      _statusMessage = "Retrying initialization...";
    });
    _initializeApp();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppTheme.primaryDark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.primaryDark,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryDark,
                AppTheme.secondaryDark,
                AppTheme.primaryDark,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: AnimatedBuilder(
                        animation: _logoScaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _logoScaleAnimation.value,
                            child: _buildLogo(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isInitializing) ...[
                        SizedBox(
                          width: 6.w,
                          height: 6.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          _statusMessage,
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ] else if (_showRetryButton) ...[
                        CustomIconWidget(
                          iconName: 'error_outline',
                          color: AppTheme.errorColor,
                          size: 8.w,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _statusMessage,
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 3.h),
                        ElevatedButton(
                          onPressed: _retryInitialization,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentColor,
                            foregroundColor: AppTheme.textPrimary,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 1.5.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Retry',
                            style: AppTheme.darkTheme.textTheme.labelLarge
                                ?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.accentColor,
                AppTheme.accentColor.withValues(alpha: 0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accentColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'movie',
              color: AppTheme.textPrimary,
              size: 12.w,
            ),
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          'MovieFlix',
          style: AppTheme.darkTheme.textTheme.headlineLarge?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Discover Amazing Movies',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            fontSize: 12.sp,
            color: AppTheme.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
