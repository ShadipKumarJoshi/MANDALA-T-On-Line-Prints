import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/edit_sell/presentation/view/edit_sell_design_view.dart';
import 'package:final_assignment/features/sell/presentation/navigator/sell_design_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editSellDesignViewNavigatorProvider =
    Provider<EditSellDesignViewNavigator>((ref) {
  return EditSellDesignViewNavigator();  
});

class EditSellDesignViewNavigator with SellDesignViewRoute, DashboardViewRoute {}

mixin EditSellDesignViewRoute {
  openEditSellDesignView() {
    NavigateRoute.pushRoute(const EditSellDesignView(design: {},));
  }
}