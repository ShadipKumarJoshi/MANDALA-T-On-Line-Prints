import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/profile/domain/entity/profile_entity.dart';
import 'package:final_assignment/features/profile/domain/repository/i_profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileUseCaseProvider = Provider<ProfileUseCase>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return ProfileUseCase(profileRepository: profileRepository);
});

class ProfileUseCase {
  final IProfileRepository profileRepository;

  ProfileUseCase({
    required this.profileRepository,
  });

  Future<Right<dynamic, ProfileEntity>> getUser() {
    return profileRepository.getUser();
  }
}