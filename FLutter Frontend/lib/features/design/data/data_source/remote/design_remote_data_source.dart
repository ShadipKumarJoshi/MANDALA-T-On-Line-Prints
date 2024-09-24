import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/design/data/dto/pagination_dto.dart';
import 'package:final_assignment/features/design/data/model/design_api_model.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared_prefs/user_shared_prefs.dart';

final designRemoteDataSourceProvider = Provider<DesignRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final designApiModel = ref.watch(designApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return DesignRemoteDataSource(
    dio: dio,
    designApiModel: designApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class DesignRemoteDataSource {
  final Dio dio;
  final DesignApiModel designApiModel;
  final UserSharedPrefs userSharedPrefs;

  DesignRemoteDataSource({
    required this.dio,
    required this.designApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<DesignEntity>>> getAllDesigns() async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(
        ApiEndpoints.getAllDesigns,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        final paginationDto = PaginationDto.fromJson(response.data);
        return Right(designApiModel.toEntities(paginationDto.designs));
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, List<DesignEntity>>> getPaginationDesigns(
      {required int page, required int limit}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(
        ApiEndpoints.getPaginationDesigns,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        final paginationDto = PaginationDto.fromJson(response.data);
        return Right(designApiModel.toEntities(paginationDto.designs));
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}
