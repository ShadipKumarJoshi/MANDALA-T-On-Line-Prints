// sell_list_tile.dart

import 'package:flutter/material.dart';

class SellListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;  // New field for price
  final String category;  // New field for category
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SellListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(imageUrl),
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description),
                Text('Category: $category'),  // Display category
                Text('Price: $price'),  // Display price
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Edit'),
                onPressed: onEdit,
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Delete'),
                onPressed: onDelete,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
