import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/profile/presentation/navigator/profile_navigator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<ProfileViewNavigator>(),
  MockSpec<UserSharedPrefs>()
])
void main() {
TestWidgetsFlutterBinding.ensureInitialized();

late AuthUseCase mockAuthUsecase;
late ProfileViewNavigator mockProfileViewNavigator;
late UserSharedPrefs mockUserSharedPrefs;




}