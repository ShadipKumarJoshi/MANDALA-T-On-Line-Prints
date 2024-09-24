import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/orders/data/dto/get_all_order_dto.dart';
import 'package:final_assignment/features/orders/data/model/order_api_model.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderRemoteDataSourceProvider = Provider<OrderRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final orderApiModel = ref.watch(orderApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return OrderRemoteDataSource(
    dio: dio,
    orderApiModel: orderApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class OrderRemoteDataSource {
  final Dio dio;
  final OrderApiModel orderApiModel;
  final UserSharedPrefs userSharedPrefs;

  OrderRemoteDataSource({
    required this.dio,
    required this.orderApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> createOrder(OrderEntity orderEntity) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.post(
        ApiEndpoints.createOrder,
        data: OrderApiModel.fromEntity(orderEntity).toJson(),
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
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      // print("Error: $e");
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<OrderEntity>>> getOrder() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndpoints.getOrder,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 201) {
        print(response.data);

        print(response.data['order'].runtimeType);
        final data = GetAllOrderDto.fromJson(response.data).orders;

        final order = data.map((e) {
          return e.toEntity();
        }).toList();
        return Right(order);
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      print("Error: $e");
      return Left(Failure(error: e.toString()));
    }
  }
}
