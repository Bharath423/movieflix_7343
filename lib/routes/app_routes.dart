import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/movie_list_screen/movie_list_screen.dart';
import '../presentation/favorites_screen/favorites_screen.dart';
import '../presentation/movie_detail_screen/movie_detail_screen.dart';
import '../presentation/search_screen/search_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String movieListScreen = '/movie-list-screen';
  static const String favoritesScreen = '/favorites-screen';
  static const String movieDetailScreen = '/movie-detail-screen';
  static const String searchScreen = '/search-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    movieListScreen: (context) => const MovieListScreen(),
    favoritesScreen: (context) => const FavoritesScreen(),
    movieDetailScreen: (context) => const MovieDetailScreen(),
    searchScreen: (context) => const SearchScreen(),
    // TODO: Add your other routes here
  };
}
