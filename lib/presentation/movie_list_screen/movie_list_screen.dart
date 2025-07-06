import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/movie_card_widget.dart';
import './widgets/movie_shimmer_widget.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, dynamic>> _movies = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String _errorMessage = '';
  int _currentPage = 1;
  bool _hasMoreData = true;

  // Mock movie data
  final List<Map<String, dynamic>> _mockMovies = [
    {
      "id": 1,
      "title": "Guardians of the Galaxy Vol. 3",
      "overview":
          "Peter Quill, still reeling from the loss of Gamora, must rally his team around him to defend the universe along with protecting one of their own.",
      "poster_path":
          "https://images.unsplash.com/photo-1489599735734-79b4212bea40?w=500&h=750&fit=crop",
      "release_date": "2023-05-05",
      "vote_average": 8.1,
      "backdrop_path":
          "https://images.unsplash.com/photo-1489599735734-79b4212bea40?w=1920&h=1080&fit=crop"
    },
    {
      "id": 2,
      "title": "Spider-Man: Across the Spider-Verse",
      "overview":
          "After reuniting with Gwen Stacy, Brooklyn's full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse.",
      "poster_path":
          "https://images.unsplash.com/photo-1635805737707-575885ab0820?w=500&h=750&fit=crop",
      "release_date": "2023-06-02",
      "vote_average": 8.7,
      "backdrop_path":
          "https://images.unsplash.com/photo-1635805737707-575885ab0820?w=1920&h=1080&fit=crop"
    },
    {
      "id": 3,
      "title": "The Flash",
      "overview":
          "Barry Allen uses his super speed to change the past, but his attempt to save his family creates a world without super heroes.",
      "poster_path":
          "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?w=500&h=750&fit=crop",
      "release_date": "2023-06-16",
      "vote_average": 6.8,
      "backdrop_path":
          "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?w=1920&h=1080&fit=crop"
    },
    {
      "id": 4,
      "title": "Transformers: Rise of the Beasts",
      "overview":
          "A '90s globetrotting adventure that introduces the Maximals, Predacons, and Terrorcons to the existing battle on earth.",
      "poster_path":
          "https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=500&h=750&fit=crop",
      "release_date": "2023-06-09",
      "vote_average": 7.2,
      "backdrop_path":
          "https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=1920&h=1080&fit=crop"
    },
    {
      "id": 5,
      "title": "Indiana Jones and the Dial of Destiny",
      "overview":
          "Finding himself in a new era, approaching retirement, Indy wrestles with fitting into a world that seems to have outgrown him.",
      "poster_path":
          "https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=500&h=750&fit=crop",
      "release_date": "2023-06-30",
      "vote_average": 6.9,
      "backdrop_path":
          "https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=1920&h=1080&fit=crop"
    },
    {
      "id": 6,
      "title": "Mission: Impossible – Dead Reckoning Part One",
      "overview":
          "Ethan Hunt and his IMF team embark on their most dangerous mission yet: To track down a terrifying new weapon.",
      "poster_path":
          "https://images.unsplash.com/photo-1574267432553-4b4628081c31?w=500&h=750&fit=crop",
      "release_date": "2023-07-12",
      "vote_average": 7.8,
      "backdrop_path":
          "https://images.unsplash.com/photo-1574267432553-4b4628081c31?w=1920&h=1080&fit=crop"
    },
    {
      "id": 7,
      "title": "Oppenheimer",
      "overview":
          "The story of J. Robert Oppenheimer's role in the development of the atomic bomb during World War II.",
      "poster_path":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=750&fit=crop",
      "release_date": "2023-07-21",
      "vote_average": 8.4,
      "backdrop_path":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=1920&h=1080&fit=crop"
    },
    {
      "id": 8,
      "title": "Barbie",
      "overview":
          "Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land.",
      "poster_path":
          "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500&h=750&fit=crop",
      "release_date": "2023-07-21",
      "vote_average": 7.1,
      "backdrop_path":
          "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=1920&h=1080&fit=crop"
    },
    {
      "id": 9,
      "title": "Fast X",
      "overview":
          "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted and outdriven every foe.",
      "poster_path":
          "https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=500&h=750&fit=crop",
      "release_date": "2023-05-19",
      "vote_average": 7.0,
      "backdrop_path":
          "https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=1920&h=1080&fit=crop"
    },
    {
      "id": 10,
      "title": "John Wick: Chapter 4",
      "overview":
          "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table.",
      "poster_path":
          "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=500&h=750&fit=crop",
      "release_date": "2023-03-24",
      "vote_average": 7.8,
      "backdrop_path":
          "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=1920&h=1080&fit=crop"
    },
    {
      "id": 11,
      "title": "Scream VI",
      "overview":
          "Following the latest Ghostface killings, the four survivors leave Woodsboro behind and start a fresh chapter.",
      "poster_path":
          "https://images.unsplash.com/photo-1489599735734-79b4212bea40?w=500&h=750&fit=crop",
      "release_date": "2023-03-10",
      "vote_average": 6.8,
      "backdrop_path":
          "https://images.unsplash.com/photo-1489599735734-79b4212bea40?w=1920&h=1080&fit=crop"
    },
    {
      "id": 12,
      "title": "Avatar: The Way of Water",
      "overview":
          "Set more than a decade after the events of the first film, learn the story of the Sully family.",
      "poster_path":
          "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&h=750&fit=crop",
      "release_date": "2022-12-16",
      "vote_average": 7.6,
      "backdrop_path":
          "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1920&h=1080&fit=crop"
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadMovies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _hasMoreData) {
        _loadMoreMovies();
      }
    }
  }

  Future<void> _loadMovies() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Simulate random error (10% chance)
      if (DateTime.now().millisecond % 10 == 0) {
        throw Exception('Network error occurred');
      }

      final startIndex = 0;
      final endIndex = startIndex + 6;
      final movieBatch = _mockMovies.sublist(startIndex,
          endIndex > _mockMovies.length ? _mockMovies.length : endIndex);

      setState(() {
        _movies = List.from(movieBatch);
        _currentPage = 1;
        _isLoading = false;
        _hasMoreData = movieBatch.length == 6;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _loadMoreMovies() async {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      final nextPage = _currentPage + 1;
      final startIndex = (_currentPage) * 6;
      final endIndex = startIndex + 6;

      if (startIndex >= _mockMovies.length) {
        setState(() {
          _isLoadingMore = false;
          _hasMoreData = false;
        });
        return;
      }

      final movieBatch = _mockMovies.sublist(startIndex,
          endIndex > _mockMovies.length ? _mockMovies.length : endIndex);

      setState(() {
        _movies.addAll(movieBatch);
        _currentPage = nextPage;
        _isLoadingMore = false;
        _hasMoreData = endIndex < _mockMovies.length;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    await _loadMovies();
  }

  void _navigateToMovieDetail(Map<String, dynamic> movie) {
    Navigator.pushNamed(
      context,
      '/movie-detail-screen',
      arguments: movie,
    );
  }

  void _navigateToSearch() {
    Navigator.pushNamed(context, '/search-screen');
  }

  void _navigateToFavorites() {
    Navigator.pushNamed(context, '/favorites-screen');
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 12.h,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'MovieFlix',
          style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        centerTitle: false,
        titlePadding: EdgeInsets.only(left: 4.w, bottom: 2.h),
      ),
      actions: [
        IconButton(
          onPressed: _navigateToSearch,
          icon: CustomIconWidget(
            iconName: 'search',
            color: AppTheme.textPrimary,
            size: 6.w,
          ),
          tooltip: 'Search Movies',
        ),
        IconButton(
          onPressed: _navigateToFavorites,
          icon: CustomIconWidget(
            iconName: 'favorite',
            color: AppTheme.accentColor,
            size: 6.w,
          ),
          tooltip: 'Favorites',
        ),
        SizedBox(width: 2.w),
      ],
    );
  }

  Widget _buildMovieList() {
    if (_isLoading && _movies.isEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => MovieShimmerWidget(),
          childCount: 6,
        ),
      );
    }

    if (_hasError && _movies.isEmpty) {
      return SliverFillRemaining(
        child: _buildErrorState(),
      );
    }

    if (_movies.isEmpty) {
      return SliverFillRemaining(
        child: _buildEmptyState(),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < _movies.length) {
            return MovieCardWidget(
              movie: _movies[index],
              onTap: () => _navigateToMovieDetail(_movies[index]),
            );
          } else if (_isLoadingMore) {
            return MovieShimmerWidget();
          }
          return null;
        },
        childCount: _movies.length + (_isLoadingMore ? 1 : 0),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'error_outline',
              color: AppTheme.errorColor,
              size: 20.w,
            ),
            SizedBox(height: 3.h),
            Text(
              'Oops! Something went wrong',
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Please check your internet connection and try again.',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            ElevatedButton.icon(
              onPressed: _loadMovies,
              icon: CustomIconWidget(
                iconName: 'refresh',
                color: AppTheme.textPrimary,
                size: 5.w,
              ),
              label: Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'movie',
              color: AppTheme.textSecondary,
              size: 20.w,
            ),
            SizedBox(height: 3.h),
            Text(
              'No movies found',
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Pull down to refresh and discover trending movies.',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        color: AppTheme.accentColor,
        backgroundColor: AppTheme.secondaryDark,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _buildAppBar(),
            _buildMovieList(),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 2.h),
            ),
          ],
        ),
      ),
    );
  }
}
