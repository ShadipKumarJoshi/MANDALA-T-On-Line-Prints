// SubView with stateless

import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:final_assignment/core/common/colors.dart';
import 'package:final_assignment/features/cart/presentation/view/cart_view.dart';
import 'package:final_assignment/features/customize/presentation/view/customize_view.dart';
import 'package:final_assignment/features/dashboard/presentation/viewmodel/dashboard_view_model.dart';
import 'package:final_assignment/features/design/presentation/view/design_view.dart';
import 'package:final_assignment/features/menu/presentation/view/menu_view.dart';
import 'package:final_assignment/features/sell/presentation/view/sell_design_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  // to highlight the navbar
  int _selectedIndex = 0;

  // list creation for highlighting View icon
  final List<Widget> lstBottomView = [
    const DesignView(),
    const SellDesignView(),
    const CustomizeView(),
    const CartView(),
    const MenuView()
  ];

// proximity sensor
  double _proximityValue = 0;
  bool _isDialogShowing = false;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();

    _streamSubscription.add(
      proximityEvents!.listen(
        (ProximityEvent event) {
          setState(() {
            _proximityValue = event.proximity;
            if (_proximityValue < 0.9 && !_isDialogShowing) {
              _showProximityDialog();
            } else if (_proximityValue >= 0.9 && _isDialogShowing) {
              Navigator.of(context).pop();
              _isDialogShowing = false;
            }
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }

  void _showProximityDialog() {
    _isDialogShowing = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text('You are too close to the proximity sensor!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _isDialogShowing = false;
              },
            ),
          ],
        );
      },
    ).then((_) {
      _isDialogShowing = false;
    });
  }

  // Method to get the color of the icon based on the selected index
  // Color _getIconColor(int index) {
  //   return _selectedIndex == index ? Colors.black : Colors.white;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: goldColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // First Container with person icon
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  // image: AssetImage('assets/images/nav_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  ref
                      .read(dashboardViewModelProvider.notifier)
                      .openProfileView();
                },
                icon: const Icon(Icons.person),
              ),
            ),

            // Second Container with dashboard logo
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/logo_navbar.png',
                  height: 230.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Third Container with notification icon
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                      // image: AssetImage('assets/images/nav_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ref
                          .read(dashboardViewModelProvider.notifier)
                          .openFavouritesView();
                    },
                    icon: const Icon(Icons.favorite),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '1', // This could be a dynamic value
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/dashboard_bg.jpg'), // Replace with your background image asset
                // 'assets/images/dashboard_bg_dark.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content
          lstBottomView[_selectedIndex],
        ],
      ),

      // body: lstBottomView[_selectedIndex],

      // Curved Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        color: goldColor, // Set the navigation bar color to gold
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.format_paint, color: Colors.black),
            label: 'Design',
            labelStyle: TextStyle(fontSize: 11),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.sell, color: Colors.black),
            label: 'Sell',
            labelStyle: TextStyle(fontSize: 11),
          ),
          CurvedNavigationBarItem(
            // child: Icon(Icons.home, color: _getIconColor(0)),
            child: Icon(Icons.palette, color: Colors.black),
            label: 'Customize',
            labelStyle: TextStyle(fontSize: 11),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.shopping_cart, color: Colors.black),
            label: 'Cart',
            labelStyle: TextStyle(fontSize: 11),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.menu, color: Colors.black),
            label: 'Menu',
            labelStyle: TextStyle(fontSize: 11),
          ),
        ],

        // Handle button tap
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
