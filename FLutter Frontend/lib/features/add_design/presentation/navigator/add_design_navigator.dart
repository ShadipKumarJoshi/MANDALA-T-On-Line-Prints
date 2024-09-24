import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/add_design/presentation/view/add_design_view.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/edit_sell/presentation/view/edit_sell_design_view.dart';
import 'package:final_assignment/features/sell/presentation/navigator/sell_design_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addDesignViewNavigatorProvider =
    Provider<AddDesignViewNavigator>((ref) {
  return AddDesignViewNavigator();  
});

class AddDesignViewNavigator with SellDesignViewRoute, DashboardViewRoute {}

mixin AddDesignViewRoute {
  openAddDesignView() {
    NavigateRoute.pushRoute(const AddDesignView());
  }
}