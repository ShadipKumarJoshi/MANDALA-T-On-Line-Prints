import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/profile/data/repository/profile_remote_repository.dart';
import 'package:final_assignment/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<IProfileRepository>((ref) => ref.read(profileRemoteRepository));

abstract class IProfileRepository {
  Future<Right<dynamic, ProfileEntity>> getUser();
}