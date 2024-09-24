import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';

class FavouritesState {
  final List<FavouritesEntity> items;
  final bool isLoading;
  final String? error;

  FavouritesState({
    required this.items,
    required this.isLoading,
    required this.error,
  });

  factory FavouritesState.initial() {
    return FavouritesState(
      items: [],
      isLoading: false,
      error: null,
    );
  }

  FavouritesState copyWith({
    List<FavouritesEntity>? items,
    bool? isLoading,
    String? error,
  }) {
    return FavouritesState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  int get totalItems {
    return items.length;
  }
}
