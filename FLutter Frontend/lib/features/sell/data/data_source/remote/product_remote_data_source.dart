import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/sell/data/dto/product_dto.dart';
import 'package:final_assignment/features/sell/data/model/product_api_model.dart';
import 'package:final_assignment/features/sell/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared_prefs/user_shared_prefs.dart';

final productRemoteDataSourceProvider =
    Provider<ProductRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final productApiModel = ref.watch(productApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return ProductRemoteDataSource(
    dio: dio,
    productApiModel: productApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class ProductRemoteDataSource {
  final Dio dio;
  final ProductApiModel productApiModel;
  final UserSharedPrefs userSharedPrefs;

  ProductRemoteDataSource({
    required this.dio,
    required this.productApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<ProductEntity>>> getAllProduct() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold((l) => throw Failure(error: l.error), (r) => token = r);
      final response = await dio.get(
        ApiEndpoints.getAllProduct,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        final productDto = ProductDto.fromJson(response.data);
        return Right(productApiModel.toEntities(productDto.products));
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}
