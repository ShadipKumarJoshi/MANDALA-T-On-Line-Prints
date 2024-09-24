import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/design/data/repository/design_remote_repository.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final designRepositoryProvider =
    Provider<IDesignRepository>((ref) => ref.read(designRemoteRepository));

abstract class IDesignRepository {
  Future<Either<Failure, List<DesignEntity>>> getPaginationDesigns(
      int page, int limit);
  Future<Either<Failure, List<DesignEntity>>> getAllDesigns();
}
