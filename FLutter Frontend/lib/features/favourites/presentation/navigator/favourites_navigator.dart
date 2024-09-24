import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/forgot_password_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/favourites/presentation/view/favourites_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouritesViewNavigatorProvider = Provider((ref) => FavouritesViewNavigator());

class FavouritesViewNavigator
    with RegisterViewRoute, ForgotPasswordViewRoute, DashboardViewRoute {}

mixin FavouritesViewRoute {
  openFavouritesView() {
    NavigateRoute.pushRoute(const FavouritesView());
  }
}
