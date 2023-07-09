import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/search_places_repo.dart';

class GetSearchedAddressesUsecase {
  final SearchPlacesRepo _searchPlacesRepo = sl<SearchPlacesRepo>();

  Future<Either<Failure, List<Address>>> call(String searchText) async {
    try {
      return Right(await _searchPlacesRepo.getSearchedAddresses(searchText));
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}