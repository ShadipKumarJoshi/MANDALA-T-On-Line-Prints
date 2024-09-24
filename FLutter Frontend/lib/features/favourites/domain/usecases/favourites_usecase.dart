import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:final_assignment/features/favourites/domain/repository/i_favourites_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouritesUsecaseProvider = Provider<FavouritesUsecase>((ref) {
  final favouritesRepository = ref.watch(favouritesRepositoryProvider);
  return FavouritesUsecase(favouritesRepository: favouritesRepository);
});

class FavouritesUsecase {
  final IFavouritesRepository favouritesRepository;

  FavouritesUsecase({required this.favouritesRepository});

  Future<Either<Failure, bool>> addToFavourites(
      FavouritesEntity favouritesEntity) async {
    return favouritesRepository.addToFavourites(favouritesEntity);
  }

  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    return favouritesRepository.getFavourites();
  }

  Future<Either<Failure, bool>> removeFromFavourites(String productId) async {
    return favouritesRepository.removeFromFavourites(productId);
  }
}
