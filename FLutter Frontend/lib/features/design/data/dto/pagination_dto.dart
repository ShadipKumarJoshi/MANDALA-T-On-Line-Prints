
import 'package:final_assignment/features/design/data/model/design_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable()
class PaginationDto {
  final bool success;
  final String message;
  final List<DesignApiModel> designs;

  PaginationDto({
    required this.success,
    required this.message,
    required this.designs,
  });

  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);
}
