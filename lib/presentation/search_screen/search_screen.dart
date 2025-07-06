import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/recent_searches_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/search_results_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<String> _recentSearches = [
    "Avengers",
    "Spider-Man",
    "Batman",
    "Inception",
    "Interstellar"
  ];

  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;
  String _currentQuery = '';

  // Filter states
  List<String> _selectedGenres = [];
  int? _selectedYear;
  double? _minRating;

  final List<Map<String, dynamic>> _mockMovies = [
    {
      "id": 1,
      "title": "Avengers: Endgame",
      "year": "2019",
      "rating": 8.4,
      "poster":
          "https://images.unsplash.com/photo-1635805737707-575885ab0820?w=300&h=450&fit=crop",
      "genres": ["Action", "Adventure", "Drama"]
    },
    {
      "id": 2,
      "title": "Spider-Man: No Way Home",
      "year": "2021",
      "rating": 8.2,
      "poster":
          "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?w=300&h=450&fit=crop",
      "genres": ["Action", "Adventure", "Sci-Fi"]
    },
    {
      "id": 3,
      "title": "The Batman",
      "year": "2022",
      "rating": 7.8,
      "poster":
          "https://images.unsplash.com/photo-1509347528160-9329d33b2588?w=300&h=450&fit=crop",
      "genres": ["Action", "Crime", "Drama"]
    },
    {
      "id": 4,
      "title": "Inception",
      "year": "2010",
      "rating": 8.8,
      "poster":
          "https://images.unsplash.com/photo-1489599735734-79b4212bea40?w=300&h=450&fit=crop",
      "genres": ["Action", "Sci-Fi", "Thriller"]
    },
    {
      "id": 5,
      "title": "Interstellar",
      "year": "2014",
      "rating": 8.6,
      "poster":
          "https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?w=300&h=450&fit=crop",
      "genres": ["Adventure", "Drama", "Sci-Fi"]
    },
    {
      "id": 6,
      "title": "Top Gun: Maverick",
      "year": "2022",
      "rating": 8.3,
      "poster":
          "https://images.unsplash.com/photo-1540979388789-6cee28a1cdc9?w=300&h=450&fit=crop",
      "genres": ["Action", "Drama"]
    },
    {
      "id": 7,
      "title": "Dune",
      "year": "2021",
      "rating": 8.0,
      "poster":
          "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=450&fit=crop",
      "genres": ["Adventure", "Drama", "Sci-Fi"]
    },
    {
      "id": 8,
      "title": "No Time to Die",
      "year": "2021",
      "rating": 7.3,
      "poster":
          "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=450&fit=crop",
      "genres": ["Action", "Adventure", "Thriller"]
    }
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _hasSearched = false;
        _currentQuery = '';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _currentQuery = query;
    });

    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        List<Map<String, dynamic>> results = _mockMovies.where((movie) {
          bool matchesQuery = (movie["title"] as String)
              .toLowerCase()
              .contains(query.toLowerCase());

          bool matchesGenre = _selectedGenres.isEmpty ||
              (_selectedGenres
                  .any((genre) => (movie["genres"] as List).contains(genre)));

          bool matchesYear = _selectedYear == null ||
              movie["year"] == _selectedYear.toString();

          bool matchesRating =
              _minRating == null || (movie["rating"] as double) >= _minRating!;

          return matchesQuery && matchesGenre && matchesYear && matchesRating;
        }).toList();

        setState(() {
          _searchResults = results;
          _isSearching = false;
          _hasSearched = true;
        });
      }
    });
  }

  void _addToRecentSearches(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      _recentSearches.remove(query);
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 10) {
        _recentSearches = _recentSearches.take(10).toList();
      }
    });
  }

  void _removeFromRecentSearches(String query) {
    setState(() {
      _recentSearches.remove(query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResults = [];
      _hasSearched = false;
      _currentQuery = '';
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheetWidget(
        selectedGenres: _selectedGenres,
        selectedYear: _selectedYear,
        minRating: _minRating,
        onFiltersApplied: (genres, year, rating) {
          setState(() {
            _selectedGenres = genres;
            _selectedYear = year;
            _minRating = rating;
          });
          if (_currentQuery.isNotEmpty) {
            _performSearch(_currentQuery);
          }
        },
      ),
    );
  }

  void _navigateToMovieDetail(Map<String, dynamic> movie) {
    Navigator.pushNamed(context, '/movie-detail-screen', arguments: movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
        ),
        title: Text(
          'Search Movies',
          style: AppTheme.darkTheme.textTheme.titleLarge,
        ),
        actions: [
          if (_selectedGenres.isNotEmpty ||
              _selectedYear != null ||
              _minRating != null)
            Container(
              margin: EdgeInsets.only(right: 4.w),
              child: IconButton(
                onPressed: _showFilterBottomSheet,
                icon: Stack(
                  children: [
                    CustomIconWidget(
                      iconName: 'filter_list',
                      color: AppTheme.accentColor,
                      size: 24,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              margin: EdgeInsets.only(right: 4.w),
              child: IconButton(
                onPressed: _showFilterBottomSheet,
                icon: CustomIconWidget(
                  iconName: 'filter_list',
                  color: AppTheme.textSecondary,
                  size: 24,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            SearchBarWidget(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: _performSearch,
              onClear: _clearSearch,
              onSubmitted: (query) {
                _addToRecentSearches(query);
                _performSearch(query);
              },
            ),

            // Content Area
            Expanded(
              child: _currentQuery.isEmpty
                  ? RecentSearchesWidget(
                      recentSearches: _recentSearches,
                      onSearchTap: (query) {
                        _searchController.text = query;
                        _performSearch(query);
                      },
                      onRemove: _removeFromRecentSearches,
                    )
                  : SearchResultsWidget(
                      isLoading: _isSearching,
                      results: _searchResults,
                      hasSearched: _hasSearched,
                      query: _currentQuery,
                      onMovieTap: _navigateToMovieDetail,
                      onRefresh: () async {
                        _performSearch(_currentQuery);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
