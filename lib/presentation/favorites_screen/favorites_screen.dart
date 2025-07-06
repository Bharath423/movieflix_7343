import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_favorites_widget.dart';
import './widgets/favorite_movie_card_widget.dart';
import './widgets/favorites_sort_bottom_sheet.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isLoading = false;
  bool _isMultiSelectMode = false;
  String _currentSortOption = 'Date Added';
  String _searchQuery = '';
  final Set<int> _selectedMovies = {};
  final TextEditingController _searchController = TextEditingController();

  // Mock favorite movies data
  final List<Map<String, dynamic>> _favoriteMovies = [
    {
      "id": 1,
      "title": "The Dark Knight",
      "posterUrl":
          "https://images.unsplash.com/photo-1489599735734-79b4625d1d17?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "releaseDate": "2008-07-18",
      "dateAdded": "2024-01-15",
      "personalRating": 9.5,
      "overview":
          "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice."
    },
    {
      "id": 2,
      "title": "Inception",
      "posterUrl":
          "https://images.unsplash.com/photo-1440404653325-ab127d49abc1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "releaseDate": "2010-07-16",
      "dateAdded": "2024-01-10",
      "personalRating": 9.0,
      "overview":
          "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O."
    },
    {
      "id": 3,
      "title": "Interstellar",
      "posterUrl":
          "https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "releaseDate": "2014-11-07",
      "dateAdded": "2024-01-12",
      "personalRating": 8.8,
      "overview":
          "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival."
    },
    {
      "id": 4,
      "title": "The Matrix",
      "posterUrl":
          "https://images.unsplash.com/photo-1518709268805-4e9042af2176?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "releaseDate": "1999-03-31",
      "dateAdded": "2024-01-08",
      "personalRating": 9.2,
      "overview":
          "A computer programmer is led to fight an underground war against powerful computers who have constructed his entire reality with a system called the Matrix."
    },
    {
      "id": 5,
      "title": "Pulp Fiction",
      "posterUrl":
          "https://images.unsplash.com/photo-1489599735734-79b4625d1d17?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "releaseDate": "1994-10-14",
      "dateAdded": "2024-01-05",
      "personalRating": 8.9,
      "overview":
          "The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption."
    }
  ];

  List<Map<String, dynamic>> get _filteredMovies {
    List<Map<String, dynamic>> filtered = _favoriteMovies;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((movie) => (movie['title'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Sort movies based on current sort option
    switch (_currentSortOption) {
      case 'Title':
        filtered.sort(
            (a, b) => (a['title'] as String).compareTo(b['title'] as String));
        break;
      case 'Release Date':
        filtered.sort((a, b) => DateTime.parse(b['releaseDate'] as String)
            .compareTo(DateTime.parse(a['releaseDate'] as String)));
        break;
      case 'Personal Rating':
        filtered.sort((a, b) => (b['personalRating'] as double)
            .compareTo(a['personalRating'] as double));
        break;
      case 'Date Added':
      default:
        filtered.sort((a, b) => DateTime.parse(b['dateAdded'] as String)
            .compareTo(DateTime.parse(a['dateAdded'] as String)));
        break;
    }

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshFavorites() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedMovies.clear();
      }
    });
  }

  void _toggleMovieSelection(int movieId) {
    setState(() {
      if (_selectedMovies.contains(movieId)) {
        _selectedMovies.remove(movieId);
      } else {
        _selectedMovies.add(movieId);
      }
    });
  }

  void _removeSelectedMovies() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remove from Favorites',
            style: AppTheme.darkTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Are you sure you want to remove ${_selectedMovies.length} movie${_selectedMovies.length > 1 ? 's' : ''} from your favorites?',
            style: AppTheme.darkTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _favoriteMovies.removeWhere(
                      (movie) => _selectedMovies.contains(movie['id']));
                  _selectedMovies.clear();
                  _isMultiSelectMode = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => FavoritesSortBottomSheet(
        currentSortOption: _currentSortOption,
        onSortChanged: (sortOption) {
          setState(() {
            _currentSortOption = sortOption;
          });
        },
      ),
    );
  }

  void _navigateToMovieDetail(Map<String, dynamic> movie) {
    Navigator.pushNamed(
      context,
      '/movie-detail-screen',
      arguments: movie,
    );
  }

  void _navigateToMovieList() {
    Navigator.pushNamed(context, '/movie-list-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryDark,
        elevation: 0,
        title: _isMultiSelectMode
            ? Text(
                '${_selectedMovies.length} selected',
                style: AppTheme.darkTheme.textTheme.titleLarge,
              )
            : Text(
                'My Favorites',
                style: AppTheme.darkTheme.textTheme.titleLarge,
              ),
        leading: _isMultiSelectMode
            ? IconButton(
                onPressed: _toggleMultiSelectMode,
                icon: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.textPrimary,
                  size: 24,
                ),
              )
            : null,
        actions: [
          if (!_isMultiSelectMode && _favoriteMovies.isNotEmpty) ...[
            IconButton(
              onPressed: _showSortOptions,
              icon: CustomIconWidget(
                iconName: 'sort',
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ),
            IconButton(
              onPressed: _toggleMultiSelectMode,
              icon: CustomIconWidget(
                iconName: 'checklist',
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ),
          ],
        ],
      ),
      body: _favoriteMovies.isEmpty
          ? EmptyFavoritesWidget(
              onBrowseMovies: _navigateToMovieList,
            )
          : Column(
              children: [
                // Search Bar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    style: AppTheme.darkTheme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Search favorites...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'search',
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              icon: CustomIconWidget(
                                iconName: 'clear',
                                color: AppTheme.textSecondary,
                                size: 20,
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: AppTheme.secondaryDark,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                    ),
                  ),
                ),

                // Movies List
                Expanded(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.accentColor,
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _refreshFavorites,
                          color: AppTheme.accentColor,
                          backgroundColor: AppTheme.secondaryDark,
                          child: _filteredMovies.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconWidget(
                                        iconName: 'search_off',
                                        color: AppTheme.textSecondary,
                                        size: 64,
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        'No movies found',
                                        style: AppTheme
                                            .darkTheme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        'Try adjusting your search',
                                        style: AppTheme
                                            .darkTheme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  itemCount: _filteredMovies.length,
                                  itemBuilder: (context, index) {
                                    final movie = _filteredMovies[index];
                                    final movieId = movie['id'] as int;
                                    final isSelected =
                                        _selectedMovies.contains(movieId);

                                    return FavoriteMovieCardWidget(
                                      movie: movie,
                                      isMultiSelectMode: _isMultiSelectMode,
                                      isSelected: isSelected,
                                      onTap: () {
                                        if (_isMultiSelectMode) {
                                          _toggleMovieSelection(movieId);
                                        } else {
                                          _navigateToMovieDetail(movie);
                                        }
                                      },
                                      onLongPress: () {
                                        if (!_isMultiSelectMode) {
                                          _toggleMultiSelectMode();
                                          _toggleMovieSelection(movieId);
                                        }
                                      },
                                      onRemove: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Remove from Favorites',
                                                style: AppTheme.darkTheme
                                                    .textTheme.titleLarge,
                                              ),
                                              content: Text(
                                                'Are you sure you want to remove "${movie['title']}" from your favorites?',
                                                style: AppTheme.darkTheme
                                                    .textTheme.bodyMedium,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _favoriteMovies
                                                          .removeWhere((m) =>
                                                              m['id'] ==
                                                              movieId);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Remove'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                ),
              ],
            ),
      bottomNavigationBar: _isMultiSelectMode && _selectedMovies.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowDark,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton.icon(
                  onPressed: _removeSelectedMovies,
                  icon: CustomIconWidget(
                    iconName: 'delete',
                    color: AppTheme.textPrimary,
                    size: 20,
                  ),
                  label: Text(
                      'Remove ${_selectedMovies.length} movie${_selectedMovies.length > 1 ? 's' : ''}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.errorColor,
                    foregroundColor: AppTheme.textPrimary,
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
