import 'package:final_assignment/features/design/domain/entity/design_entity.dart';

class DesignState {
  final bool isLoading;
  final String error;
  final List<DesignEntity> designs;
  final bool hasReachedMax;
  final int page;

  factory DesignState.initial() {
    return DesignState(
      isLoading: false,
      error: '',
      designs: [],
      page: 0,
      hasReachedMax: false,
    );
  }

  DesignState({
    required this.isLoading,
    required this.error,
    required this.designs,
    required this.page,
    required this.hasReachedMax,
  });

  DesignState copyWith({
    bool? isLoading,
    String? error,
    List<DesignEntity>? designs,
    int? page,
    bool? hasReachedMax,
  }) {
    return DesignState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      designs: designs ?? this.designs,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
