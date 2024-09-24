
import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/favourites/domain/usecases/favourites_usecase.dart';
import 'package:final_assignment/features/favourites/presentation/state/favourites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouritesViewModelProvider =
    StateNotifierProvider<FavouritesViewModel, FavouritesState>(
  (ref) => FavouritesViewModel(
    favouritesUsecase: ref.read(favouritesUsecaseProvider),
  ),
);

class FavouritesViewModel extends StateNotifier<FavouritesState> {
  FavouritesViewModel({required this.favouritesUsecase})
      : super(FavouritesState.initial()) {
    fetchFavourites();
  }

  final FavouritesUsecase favouritesUsecase;

  Future fetchFavourites() async {
    state = state.copyWith(isLoading: true);
    final result = await favouritesUsecase.getFavourites();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) => state = state.copyWith(
        isLoading: false,
        items: data,
      ),
    );
  }

  Future<void> removeFromFavourites(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await favouritesUsecase.removeFromFavourites(id);
    result.fold(
      (failure) =>
          state = state.copyWith(error: failure.error, isLoading: false),
      (data) {
        fetchFavourites();
        showMySnackBar(message: 'Removed from favourites', color: Colors.green);
        state = state.copyWith(isLoading: false);
      },
    );
    fetchFavourites();
  }
}
