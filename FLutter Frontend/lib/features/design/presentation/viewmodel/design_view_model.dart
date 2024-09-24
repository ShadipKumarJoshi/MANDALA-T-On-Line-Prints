import 'package:final_assignment/features/design/domain/usecases/design_usecase.dart';
import 'package:final_assignment/features/design/presentation/state/design_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final designViewModelProvider =
    StateNotifierProvider<DesignViewModel, DesignState>(
  (ref) => DesignViewModel(
    designUseCase: ref.read(designUseCaseProvider),
  ),
);

class DesignViewModel extends StateNotifier<DesignState> {
  DesignViewModel({required this.designUseCase})
      : super(
          DesignState.initial(),
        ) {
    fetchDesigns();
  }

  final DesignUseCase designUseCase;

  Future resetState() async {
    state = DesignState.initial();
    fetchDesigns();
  }

  Future fetchDesigns() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final designs = currentState.designs;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await designUseCase.getPaginationDesigns(page, 12);
      result.fold(
        (failure) => state = state.copyWith(
          hasReachedMax: true,
          isLoading: false,
          error: failure.error,
        ),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              designs: [...designs, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
