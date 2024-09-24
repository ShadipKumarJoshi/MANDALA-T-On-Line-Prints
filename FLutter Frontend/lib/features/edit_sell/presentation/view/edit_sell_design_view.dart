import 'dart:convert';

import 'package:final_assignment/core/common/dashboard_Tab_View_Heading.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class EditSellDesignView extends ConsumerStatefulWidget {
  final Map design;

  const EditSellDesignView({super.key, required this.design});

  @override
  ConsumerState<EditSellDesignView> createState() => _EditSellDesignViewState();
}

class _EditSellDesignViewState extends ConsumerState<EditSellDesignView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  late UserSharedPrefs userSharedPrefs;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.design['designName']);
    _priceController =
        TextEditingController(text: widget.design['designPrice'].toString());
    _categoryController =
        TextEditingController(text: widget.design['designCategory']);
    _descriptionController =
        TextEditingController(text: widget.design['designDescription']);
  }

  Future<void> _editDesign() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final token = await userSharedPrefs.getUserToken();
        final response = await http.put(
          Uri.parse(
              'http://10.0.2.2:8000/api/design/edit/${widget.design['id']}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'designName': _nameController.text,
            'designPrice': double.parse(_priceController.text),
            'designCategory': _categoryController.text,
            'designDescription': _descriptionController.text,
          }),
        );

        var jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          // Handle success (e.g., navigate back or show a success message)
          Navigator.pop(
              context, true); // Passing 'true' as a signal to refresh the list
        } else {
          // Handle error (e.g., show error message)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonResponse['message'])),
          );
        }
      } catch (e) {
        // Handle exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
               child: DashboardTabViewHeading(text: 'Edit Designs'),),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration:
                                  const InputDecoration(labelText: 'Design Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the design name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _priceController,
                              decoration:
                                  const InputDecoration(labelText: 'Design Price'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the design price';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid price';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _categoryController,
                              decoration:
                                  const InputDecoration(labelText: 'Design Category'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the design category';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                  labelText: 'Design Description'),
                              maxLines: 4,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the design description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _editDesign,
                              child: const Text('Update Design'),
                            ),
                          ],
                        ),
                      ),
              ),
            
          ],
        ),
      ),
    );
  }
}
