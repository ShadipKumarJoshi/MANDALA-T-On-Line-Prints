import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'design_api_model.g.dart';

final designApiModelProvider = Provider<DesignApiModel>((ref) {
  return const DesignApiModel.empty();
});

@JsonSerializable()
class DesignApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String designName;
  final double designPrice;
  final String designCategory;
  final String designDescription;
  final String designImage;
  final String createAt;
  final String createdBy;

  const DesignApiModel({
    required this.id,
    required this.designName,
    required this.designPrice,
    required this.designCategory,
    required this.designDescription,
    required this.designImage,
    required this.createAt,
    required this.createdBy,
  });

  // Empty constructor
  const DesignApiModel.empty()
      : id = '',
        designName = '',
        designPrice = 0.0,
        designCategory = '',
        designDescription = '',
        designImage = '',
        createAt = '',
        createdBy = '';

  factory DesignApiModel.fromJson(Map<String, dynamic> json) =>
      _$DesignApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$DesignApiModelToJson(this);

// To entity
  DesignEntity toEntity() {
    return DesignEntity(
      id: id,
      designName: designName,
      designPrice: designPrice,
      designCategory: designCategory,
      designDescription: designDescription,
      designImage: designImage,
      createdAt: createAt,
      createdBy: createdBy,
    );
  }

  // From entity
  factory DesignApiModel.fromEntity(DesignEntity entity) {
    return DesignApiModel(
      id: entity.id,
      designName: entity.designName,
      designPrice: entity.designPrice,
      designCategory: entity.designCategory,
      designDescription: entity.designDescription,
      designImage: entity.designImage,
      createAt: entity.createdAt,
      createdBy: entity.createdBy,
    );
  }

  // To list of entity
  List<DesignEntity> toEntities(List<DesignApiModel> designs) {
    return designs.map((design) => design.toEntity()).toList();
  }

  // From list of entity
  List<DesignApiModel> fromEntities(List<DesignEntity> designs) {
    return designs.map((design) => DesignApiModel.fromEntity(design)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        designName,
        designPrice,
        designCategory,
        designDescription,
        designImage,
        createAt,
        createdBy,
      ];
}
