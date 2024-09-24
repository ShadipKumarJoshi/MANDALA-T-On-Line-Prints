import 'package:final_assignment/features/profile/domain/entity/profile_entity.dart';

class CurrentProfileState {
  final bool isLoading;
  final ProfileEntity? authEntity;
  final String? error;
  final bool isFingerprintEnabled;

  CurrentProfileState(
      {required this.isLoading,
      required this.authEntity,
      required this.error,
      required this.isFingerprintEnabled});

  factory CurrentProfileState.initial() {
    return CurrentProfileState(
        isLoading: false,
        authEntity: null,
        error: null,
        isFingerprintEnabled: false);
  }

  CurrentProfileState copyWith(
      {bool? isLoading,
      ProfileEntity? authEntity,
      String? error,
      bool? isFingerprintEnabled}) {
    return CurrentProfileState(
        isLoading: isLoading ?? this.isLoading,
        authEntity: authEntity ?? this.authEntity,
        error: error ?? this.error,
        isFingerprintEnabled:
            isFingerprintEnabled ?? this.isFingerprintEnabled);
  }
}
