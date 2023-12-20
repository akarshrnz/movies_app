import 'package:dartz/dartz.dart';
import 'package:movies_app/core/utils/error/failure.dart';
import 'package:movies_app/features/search/domain/entities/search_result_item.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String title);
}
