import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favourites/data/repository/favourites_remote_repository.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouritesRepositoryProvider = Provider<IFavouritesRepository>(
    (ref) => ref.read(favouritesRemoteRepositoryProvider));

abstract class IFavouritesRepository {
  Future<Either<Failure, bool>> addToFavourites(
      FavouritesEntity favouritesEntity);
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, bool>> removeFromFavourites(String productId);
}
