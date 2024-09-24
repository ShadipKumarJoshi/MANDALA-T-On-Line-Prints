import 'package:final_assignment/features/edit_profile/presentation/navigator/edit_profile_navigator.dart';
import 'package:final_assignment/features/profile/domain/usecases/profile_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/current_state_profile.dart';

final editProfileViewModelProvider =
    StateNotifierProvider<EditProfileViewModel, CurrentProfileState>(
  (ref) => EditProfileViewModel(
    ref.watch(editProfileViewNavigatorProvider),
    ref.read(profileUseCaseProvider),
  ),
);

// This line defines a StateNotifierProvider named editProfileViewModelProvider.
// It creates an instance of EditProfileViewModel and associates it with the editProfileViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class EditProfileViewModel extends StateNotifier<CurrentProfileState> {
  EditProfileViewModel(this.navigator, this._authUseCase)
      : super(CurrentProfileState.initial());

  final EditProfileViewNavigator navigator;
  final ProfileUseCase _authUseCase;

  // fetchCurrentUser method
  Future<void> fetchCurrentUser() async {
    state = state.copyWith(isLoading: true);
    final result = await _authUseCase.getUser();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
      },
      (data) {
        state = state.copyWith(
          isLoading: false,
          authEntity: data,
        );
      },
    );
  }

  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openProfileView() {
    navigator.openProfileView();
  }
}
