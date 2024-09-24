import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:final_assignment/features/profile/domain/entity/profile_entity.dart';
import 'package:final_assignment/features/profile/domain/repository/i_profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final profileRemoteRepository = Provider<IProfileRepository>((ref) {
  final profileRemoteDataSource = ref.watch(profileRemoteDataSourceProvider);
  return ProfileRemoteRepository(profileRemoteDataSource: profileRemoteDataSource);
});

class ProfileRemoteRepository implements IProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRemoteRepository({required this.profileRemoteDataSource});

  @override
  Future<Right<dynamic, ProfileEntity>> getUser() {
    return profileRemoteDataSource.getUser();
  }
}