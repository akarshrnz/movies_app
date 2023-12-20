import 'package:dio/dio.dart';
import 'package:movies_app/core/utils/error/exceptions.dart';
import 'package:movies_app/features/search/data/datasource/search_remote_data_source.dart';
import 'package:movies_app/features/search/domain/entities/search_result_item.dart';
import 'package:movies_app/core/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/features/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource _baseSearchRemoteDataSource;

  SearchRepositoryImpl(this._baseSearchRemoteDataSource);

  @override
  Future<Either<Failure, List<SearchResultItem>>> search(String title) async {
    try {
      final result = await _baseSearchRemoteDataSource.search(title);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message??"Something went wrong"));
    }
  }
}
