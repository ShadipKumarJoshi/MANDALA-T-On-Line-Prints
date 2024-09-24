import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favourites/data/data_source/remote/favourites_remote_data_source.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:final_assignment/features/favourites/domain/repository/i_favourites_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouritesRemoteRepositoryProvider =
    Provider<IFavouritesRepository>((ref) {
  final favouritesRemoteDataSource =
      ref.watch(favouritesRemoteDataSourceProvider);
  return FavouritesRemoteRepository(
      favouritesRemoteDataSource: favouritesRemoteDataSource);
});

class FavouritesRemoteRepository implements IFavouritesRepository {
  final FavouritesRemoteDataSource favouritesRemoteDataSource;

  FavouritesRemoteRepository({required this.favouritesRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addToFavourites(
      FavouritesEntity favouritesEntity) {
    return favouritesRemoteDataSource.addToFavourites(favouritesEntity);
  }

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() {
    return favouritesRemoteDataSource.getFavourites();
  }

  @override
  Future<Either<Failure, bool>> removeFromFavourites(String productId) {
    return favouritesRemoteDataSource.removeFromFavourites(productId);
  }
}
