import 'dart:convert';

import 'package:final_assignment/core/common/dashboard_Tab_View_Heading.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/sell/presentation/widgets/design_List_Tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SellDesignView extends ConsumerStatefulWidget {
  const SellDesignView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SellDesignViewState();
}

class _SellDesignViewState extends ConsumerState<SellDesignView> {
  List sells = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSells();
  }

  Future<void> fetchSells() async {
    final token = await ref.read(userSharedPrefsProvider).getUserToken();
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/design/getUserDesigns'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var jsonResponse = json.decode(response.body);
    if (jsonResponse['success']) {
      setState(() {
        sells = jsonResponse['data'];
      });
    } else {
      // Handle error
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Center(
              child: DashboardTabViewHeading(text: 'Sell Designs'),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: sells.length,
                      itemBuilder: (BuildContext context, int index) {
                        final sell = sells[index];
                        return SellListTile(
                          imageUrl: sell['imageUrl'] ?? '',
                          title: sell['title'] ?? 'No Title',
                          description: sell['description'] ?? 'No Description',
                          price: sell['price'] ?? 'No Price',
                          category: sell['category'] ?? 'No Category',
                          onEdit: () {
                            // Edit functionality here
                          },
                          onDelete: () {
                            // Delete functionality here
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
