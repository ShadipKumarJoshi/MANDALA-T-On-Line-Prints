import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';

class FavouritesEntity extends Equatable {
  final String? id;
  final DesignEntity designEntity;
  final String? userId;

  const FavouritesEntity({
    this.id,
    required this.designEntity,
    this.userId,
  });

  @override
  List<Object?> get props => [id, designEntity, userId];
}
