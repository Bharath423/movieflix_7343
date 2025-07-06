import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/cast_list_widget.dart';
import './widgets/genre_chips_widget.dart';
import './widgets/hero_poster_widget.dart';
import './widgets/movie_info_widget.dart';
import './widgets/plot_synopsis_widget.dart';
import './widgets/technical_specs_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _favoriteAnimationController;
  late Animation<double> _favoriteAnimation;

  bool _isAppBarTransparent = true;
  bool _isFavorite = false;
  bool _isLoading = false;
  bool _hasError = false;

  // Mock movie data
  final Map<String, dynamic> movieData = {
    "id": 1,
    "title": "Inception",
    "poster_url":
        "https://images.unsplash.com/photo-1489599735734-79b4ba5a1d6b?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "backdrop_url":
        "https://images.unsplash.com/photo-1440404653325-ab127d49abc1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "release_date": "2010-07-16",
    "runtime": 148,
    "rating": 8.8,
    "vote_count": 2156789,
    "plot":
        "Dom Cobb is a skilled thief, the absolute best in the dangerous art of extraction, stealing valuable secrets from deep within the subconscious during the dream state, when the mind is at its most vulnerable. Cobb's rare ability has made him a coveted player in this treacherous new world of corporate espionage, but it has also made him an international fugitive and cost him everything he has ever loved.",
    "genres": ["Action", "Sci-Fi", "Thriller", "Drama"],
    "cast": [
      {
        "name": "Leonardo DiCaprio",
        "character": "Dom Cobb",
        "profile_url":
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fm=jpg&q=60&w=300&ixlib=rb-4.0.3"
      },
      {
        "name": "Marion Cotillard",
        "character": "Mal",
        "profile_url":
            "https://images.unsplash.com/photo-1494790108755-2616b612b786?fm=jpg&q=60&w=300&ixlib=rb-4.0.3"
      },
      {
        "name": "Tom Hardy",
        "character": "Eames",
        "profile_url":
            "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?fm=jpg&q=60&w=300&ixlib=rb-4.0.3"
      },
      {
        "name": "Ellen Page",
        "character": "Ariadne",
        "profile_url":
            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=300&ixlib=rb-4.0.3"
      }
    ],
    "technical_specs": {
      "director": "Christopher Nolan",
      "writer": "Christopher Nolan",
      "cinematography": "Wally Pfister",
      "music": "Hans Zimmer",
      "budget": "\$160,000,000",
      "box_office": "\$836,800,000",
      "production_companies": ["Warner Bros.", "Legendary Entertainment"],
      "country": "USA, UK",
      "language": "English"
    }
  };

  @override
  void initState() {
    super.initState();
    _favoriteAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _favoriteAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _favoriteAnimationController,
      curve: Curves.elasticOut,
    ));

    _scrollController.addListener(_onScroll);
    _loadMovieData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _favoriteAnimationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bool shouldBeTransparent = _scrollController.offset < 200;
    if (_isAppBarTransparent != shouldBeTransparent) {
      setState(() {
        _isAppBarTransparent = shouldBeTransparent;
      });
    }
  }

  Future<void> _loadMovieData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    _favoriteAnimationController.forward().then((_) {
      _favoriteAnimationController.reverse();
    });

    HapticFeedback.lightImpact();
  }

  void _shareMovie() {
    HapticFeedback.selectionClick();
    // Simulate share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${movieData["title"]}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _retryLoading() {
    _loadMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: _hasError ? _buildErrorState() : _buildBody(),
      floatingActionButton: _hasError ? null : _buildFavoriteButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _isAppBarTransparent
          ? Colors.transparent
          : AppTheme.darkTheme.appBarTheme.backgroundColor,
      elevation: _isAppBarTransparent ? 0 : 2,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isAppBarTransparent
                ? AppTheme.darkTheme.colorScheme.surface.withValues(alpha: 0.8)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.darkTheme.colorScheme.onSurface,
            size: 20,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: _shareMovie,
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isAppBarTransparent
                  ? AppTheme.darkTheme.colorScheme.surface
                      .withValues(alpha: 0.8)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomIconWidget(
              iconName: 'share',
              color: AppTheme.darkTheme.colorScheme.onSurface,
              size: 20,
            ),
          ),
        ),
        SizedBox(width: 2.w),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: HeroPosterWidget(
            backdropUrl: movieData["backdrop_url"] as String,
            posterUrl: movieData["poster_url"] as String,
            title: movieData["title"] as String,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.darkTheme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                MovieInfoWidget(
                  title: movieData["title"] as String,
                  releaseDate: movieData["release_date"] as String,
                  runtime: movieData["runtime"] as int,
                  rating: movieData["rating"] as double,
                  voteCount: movieData["vote_count"] as int,
                ),
                SizedBox(height: 3.h),
                PlotSynopsisWidget(
                  plot: movieData["plot"] as String,
                ),
                SizedBox(height: 3.h),
                GenreChipsWidget(
                  genres: (movieData["genres"] as List).cast<String>(),
                ),
                SizedBox(height: 3.h),
                CastListWidget(
                  cast:
                      (movieData["cast"] as List).cast<Map<String, dynamic>>(),
                ),
                SizedBox(height: 3.h),
                TechnicalSpecsWidget(
                  specs: movieData["technical_specs"] as Map<String, dynamic>,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero poster skeleton
          Container(
            height: 50.h,
            width: double.infinity,
            color: AppTheme.darkTheme.colorScheme.surface,
            child: Center(
              child: CircularProgressIndicator(
                color: AppTheme.accentColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                // Title skeleton
                Container(
                  height: 4.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: AppTheme.darkTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 2.h),
                // Info skeleton
                Row(
                  children: [
                    Container(
                      height: 2.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: AppTheme.darkTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      height: 2.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                        color: AppTheme.darkTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'error_outline',
              color: AppTheme.errorColor,
              size: 64,
            ),
            SizedBox(height: 2.h),
            Text(
              'Failed to load movie details',
              style: AppTheme.darkTheme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Please check your connection and try again',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            ElevatedButton.icon(
              onPressed: _retryLoading,
              icon: CustomIconWidget(
                iconName: 'refresh',
                color: AppTheme.textPrimary,
                size: 20,
              ),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return AnimatedBuilder(
      animation: _favoriteAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _favoriteAnimation.value,
          child: FloatingActionButton(
            onPressed: _toggleFavorite,
            backgroundColor:
                _isFavorite ? AppTheme.accentColor : AppTheme.secondaryDark,
            child: CustomIconWidget(
              iconName: _isFavorite ? 'favorite' : 'favorite_border',
              color:
                  _isFavorite ? AppTheme.textPrimary : AppTheme.textSecondary,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
