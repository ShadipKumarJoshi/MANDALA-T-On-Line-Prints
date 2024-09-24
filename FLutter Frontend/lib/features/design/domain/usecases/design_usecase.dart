import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:final_assignment/features/design/domain/repository/i_design_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final designUseCaseProvider = Provider<DesignUseCase>((ref) {
  final designRepository = ref.watch(designRepositoryProvider);
  return DesignUseCase(designRepository: designRepository);
});

class DesignUseCase {
  final IDesignRepository designRepository;

  DesignUseCase({
    required this.designRepository,
  });

  Future<Either<Failure, List<DesignEntity>>> getPaginationDesigns(
      int page, int limit) {
    return designRepository.getPaginationDesigns(page, limit);
  }

  Future<Either<Failure, List<DesignEntity>>> getAllDesigns() {
    return designRepository.getAllDesigns();
  }
}
