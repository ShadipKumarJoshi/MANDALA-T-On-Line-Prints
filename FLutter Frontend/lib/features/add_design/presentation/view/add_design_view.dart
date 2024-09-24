import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDesignView extends ConsumerStatefulWidget {
  const AddDesignView({Key? key}) : super(key: key);

  @override
  _AddDesignViewState createState() => _AddDesignViewState();
}

class _AddDesignViewState extends ConsumerState<AddDesignView> {
  final _formKey = GlobalKey<FormState>();
  String designName = '';
  double designPrice = 0.0;
  String designCategory = 'Plants';
  String designDescription = '';
  String? designImageUrl;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Trigger your API call here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Design Name'),
              onChanged: (value) => designName = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Design Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) => designPrice = double.parse(value),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Design Category'),
              value: designCategory,
              items: const [
                DropdownMenuItem(value: 'Plants', child: Text('Plants')),
                DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
                DropdownMenuItem(value: 'Toys', child: Text('Toys')),
                DropdownMenuItem(value: 'Food', child: Text('Food')),
                DropdownMenuItem(value: 'Furniture', child: Text('Furniture')),
              ],
              onChanged: (value) => designCategory = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Design Description'),
              maxLines: 3,
              onChanged: (value) => designDescription = value,
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add Design'),
            ),
          ],
        ),
      ),
    );
  }
}
