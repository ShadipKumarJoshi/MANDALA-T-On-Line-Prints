import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/cart/data/dto/get_all_carts_dto.dart';
import 'package:final_assignment/features/cart/data/model/cart_api_model.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final cartApiModel = ref.watch(cartApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return CartRemoteDataSource(
      dio: dio, cartApiModel: cartApiModel, userSharedPrefs: userSharedPrefs);
});

class CartRemoteDataSource {
  final Dio dio;
  final CartApiModel cartApiModel;
  final UserSharedPrefs userSharedPrefs;

  CartRemoteDataSource(
      {required this.dio,
      required this.cartApiModel,
      required this.userSharedPrefs});

  Future<Either<Failure, bool>> addToCart(CartEntity cartEntity) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.post(
        ApiEndpoints.addToCart,
        data: CartApiModel.fromEntity(cartEntity).toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
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

  Future<Either<Failure, List<CartEntity>>> getCart() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndpoints.getCart,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 201) {
        // print("Cart debugggg: ${response.data}");
        final getAllCartDto = GetAllCartsDto.fromJson(response.data);
        return Right(cartApiModel.toEntityList(getAllCartDto.carts));
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

  Future<Either<Failure, bool>> removeFromCart(String productId) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.delete(
        '${ApiEndpoints.removeFromCart}/$productId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
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

  Future<Either<Failure, bool>> updateQuantity(
      String productId, int quantity, double price) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.put(
        '${ApiEndpoints.updateQuantity}/$productId',
        data: {'quantity': quantity, 'total': quantity * price},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
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

  Future<Either<Failure, bool>> clearCart() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.post(
        ApiEndpoints.clearCart,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
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

  Future<Either<Failure, bool>> changeStatus() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.put(
        ApiEndpoints.changeStatus,
        data: {'status': 'ordered'},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
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
