import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/edit_profile/presentation/navigator/edit_profile_navigator.dart';
import 'package:final_assignment/features/orders/presentation/navigator/order_navigator.dart';
import 'package:final_assignment/features/profile/presentation/view/profile_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileViewNavigatorProvider = Provider<ProfileViewNavigator>((ref) {
  return ProfileViewNavigator();
});

class ProfileViewNavigator
    with
        EditProfileViewRoute,
        LoginViewRoute,
        DashboardViewRoute,
        OrderViewRoute {}

mixin ProfileViewRoute {
  openProfileView() {
    NavigateRoute.pushRoute(const ProfileView());
  }
}
