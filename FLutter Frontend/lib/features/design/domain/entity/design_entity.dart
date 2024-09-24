import 'package:equatable/equatable.dart';

class DesignEntity extends Equatable {
  final String? id;
  final String designName;
  final double designPrice;
  final String designCategory;
  final String designDescription;
  final String designImage;
  final String createdAt;
  final String createdBy;

  const DesignEntity({
    required this.id,
    required this.designName,
    required this.designPrice,
    required this.designCategory,
    required this.designDescription,
    required this.designImage,
    required this.createdAt,
    required this.createdBy,
  });

  @override
  List<Object?> get props => [
        id,
        designName,
        designPrice,
        designCategory,
        designDescription,
        designImage,
        createdAt,
        createdBy,
      ];
}
