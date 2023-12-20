import 'package:get_it/get_it.dart';
import 'package:movies_app/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movies_app/features/movies/data/repository/movies_repository_impl.dart';
import 'package:movies_app/features/movies/domain/repository/movies_repository.dart';
import 'package:movies_app/features/movies/domain/usecases/get_all_popular_movies_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_all_top_rated_movies_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movies_usecase.dart';

import 'package:movies_app/features/search/data/datasource/search_remote_data_source.dart';
import 'package:movies_app/features/search/data/repository/search_repository_impl.dart';
import 'package:movies_app/features/search/domain/repository/search_repository.dart';
import 'package:movies_app/features/search/domain/usecases/search_usecase.dart';
import 'package:movies_app/features/search/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:movies_app/features/tv_shows/data/datasource/tv_shows_remote_data_source.dart';
import 'package:movies_app/features/tv_shows/data/repository/tv_shows_repository_impl.dart';
import 'package:movies_app/features/tv_shows/domain/repository/tv_shows_repository.dart';
import 'package:movies_app/features/tv_shows/domain/usecases/get_all_popular_tv_shows_usecase.dart';
import 'package:movies_app/features/tv_shows/domain/usecases/get_all_top_rated_tv_shows_usecase.dart';
import 'package:movies_app/features/tv_shows/domain/usecases/get_season_details_usecase.dart';
import 'package:movies_app/features/tv_shows/domain/usecases/get_tv_show_details_usecase.dart';
import 'package:movies_app/features/tv_shows/domain/usecases/get_tv_shows_usecase.dart';
import 'package:movies_app/features/tv_shows/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:movies_app/features/tv_shows/presentation/bloc/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import 'package:movies_app/features/tv_shows/presentation/bloc/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:movies_app/features/tv_shows/presentation/bloc/tv_shows_bloc/tv_shows_bloc.dart';


import 'package:movies_app/features/watchlist/data/datasource/watchlist_local_data_source.dart';
import 'package:movies_app/features/watchlist/data/repository/watchlist_repository_impl.dart';
import 'package:movies_app/features/watchlist/domain/repository/watchlist_repository.dart';
import 'package:movies_app/features/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:movies_app/features/watchlist/domain/usecases/check_if_item_added_usecase.dart';
import 'package:movies_app/features/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'package:movies_app/features/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';
import 'package:movies_app/features/watchlist/presentation/bloc/watchlist_bloc/watchlist_bloc.dart';

import '../features/movies/presentation/bloc/movie_details_bloc/movie_details_bloc.dart';
import '../features/movies/presentation/bloc/movies_bloc/movies_bloc.dart';
import '../features/movies/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import '../features/movies/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static void init() {
    // Data source
    locator.registerLazySingleton<MoviesRemoteDataSource>(
        () => MoviesRemoteDataSourceImpl());
    locator.registerLazySingleton<TVShowsRemoteDataSource>(
        () => TVShowsRemoteDataSourceImpl());
    locator.registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl());
    locator.registerLazySingleton<WatchlistLocalDataSource>(
        () => WatchlistLocalDataSourceImpl());

    // Repository
    locator.registerLazySingleton<MoviesRespository>(
        () => MoviesRepositoryImpl(locator()));
    locator.registerLazySingleton<TVShowsRepository>(
        () => TVShowsRepositoryImpl(locator()));
    locator.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(locator()));
    locator.registerLazySingleton<WatchlistRepository>(
        () => WatchListRepositoryImpl(locator()));

    // Use Cases
    locator.registerLazySingleton(() => GetMoviesDetailsUseCase(locator()));
    locator.registerLazySingleton(() => GetMoviesUseCase(locator()));
    locator.registerLazySingleton(() => GetAllPopularMoviesUseCase(locator()));
    locator.registerLazySingleton(() => GetAllTopRatedMoviesUseCase(locator()));
    locator.registerLazySingleton(() => GetTVShowsUseCase(locator()));
    locator.registerLazySingleton(() => GetTVShowDetailsUseCase(locator()));
    locator.registerLazySingleton(() => GetSeasonDetailsUseCase(locator()));
    locator.registerLazySingleton(() => GetAllPopularTVShowsUseCase(locator()));
    locator.registerLazySingleton(() => GetAllTopRatedTVShowsUseCase(locator()));
    locator.registerLazySingleton(() => SearchUseCase(locator()));
    locator.registerLazySingleton(() => GetWatchlistItemsUseCase(locator()));
    locator.registerLazySingleton(() => AddWatchlistItemUseCase(locator()));
    locator.registerLazySingleton(() => RemoveWatchlistItemUseCase(locator()));
    locator.registerLazySingleton(() => CheckIfItemAddedUseCase(locator()));

    // Bloc
    locator.registerFactory(() => MoviesBloc(locator()));
    locator.registerFactory(() => MovieDetailsBloc(locator()));
    locator.registerFactory(() => PopularMoviesBloc(locator()));
    locator.registerFactory(() => TopRatedMoviesBloc(locator()));
    locator.registerFactory(() => TVShowsBloc(locator()));
    locator.registerFactory(() => TVShowDetailsBloc(locator(), locator()));
    locator.registerFactory(() => PopularTVShowsBloc(locator()));
    locator.registerFactory(() => TopRatedTVShowsBloc(locator()));
    locator.registerFactory(() => SearchBloc(locator()));
    locator.registerFactory(() => WatchlistBloc(locator(), locator(), locator(), locator()));
  }
}
