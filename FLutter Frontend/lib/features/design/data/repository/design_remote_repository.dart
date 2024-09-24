import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/design/data/data_source/remote/design_remote_data_source.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:final_assignment/features/design/domain/repository/i_design_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final designRemoteRepository = Provider<IDesignRepository>((ref) {
  final designRemoteDataSource = ref.watch(designRemoteDataSourceProvider);
  return DesignRemoteRepository(designRemoteDataSource: designRemoteDataSource);
});

class DesignRemoteRepository implements IDesignRepository {
  final DesignRemoteDataSource designRemoteDataSource;

  DesignRemoteRepository({required this.designRemoteDataSource});

  @override
  Future<Either<Failure, List<DesignEntity>>> getPaginationDesigns(
      int page, int limit) {
    return designRemoteDataSource.getPaginationDesigns(
        page: page, limit: limit);
  }

  @override
  Future<Either<Failure, List<DesignEntity>>> getAllDesigns() {
    return designRemoteDataSource.getAllDesigns();
  }
}
