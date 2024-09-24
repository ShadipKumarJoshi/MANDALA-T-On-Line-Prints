import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/favourites/data/dto/get_all_favourites_dto.dart';
import 'package:final_assignment/features/favourites/data/model/favourites_api_model.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouritesRemoteDataSourceProvider =
    Provider<FavouritesRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final favouritesApiModel = ref.watch(favouritesApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return FavouritesRemoteDataSource(
      dio: dio,
      favouritesApiModel: favouritesApiModel,
      userSharedPrefs: userSharedPrefs);
});

class FavouritesRemoteDataSource {
  final Dio dio;
  final FavouritesApiModel favouritesApiModel;
  final UserSharedPrefs userSharedPrefs;

  FavouritesRemoteDataSource(
      {required this.dio,
      required this.favouritesApiModel,
      required this.userSharedPrefs});

  Future<Either<Failure, bool>> addToFavourites(
      FavouritesEntity favouritesEntity) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.post(
        ApiEndpoints.addToFavourites,
        data: FavouritesApiModel.fromEntity(favouritesEntity).toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndpoints.getFavourites,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        // type of response.data
        print(response.data['favorites'].runtimeType);
        final data = GetAllFavouritesDto.fromJson(response.data).favorites;

        final favorites = data.map((e) {
          return e.toEntity();
        }).toList();

        return Right(favorites);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      print("Error: $e");
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> removeFromFavourites(String productId) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.delete(
        '${ApiEndpoints.removeFromFavourites}/$productId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
