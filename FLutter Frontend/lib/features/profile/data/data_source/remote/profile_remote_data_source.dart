import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/profile/data/model/profile_api_model.dart';
import 'package:final_assignment/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRemoteDataSourceProvider =
    Provider<ProfileRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final profileApiModel = ref.watch(profileApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return ProfileRemoteDataSource(
    dio: dio,
    profileApiModel: profileApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class ProfileRemoteDataSource {
  final Dio dio;
  final ProfileApiModel profileApiModel;
  final UserSharedPrefs userSharedPrefs;

  ProfileRemoteDataSource({
    required this.dio,
    required this.profileApiModel,
    required this.userSharedPrefs,
  });

  Future<Right<dynamic, ProfileEntity>> getUser() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold((l) => throw Failure(error: l.error), (r) => token = r);
      final response = await dio.get(
        ApiEndpoints.currentUser,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        final profileDto = ProfileApiModel.fromJson(response.data);
        return Right(profileApiModel.toEntity(profileDto));
      }
      throw Failure(
        error: response.data['message'],
        statusCode: response.statusCode.toString(),
      );
    } on DioException catch (e) {
      throw Failure(error: e.error.toString());
    }
  }
}
