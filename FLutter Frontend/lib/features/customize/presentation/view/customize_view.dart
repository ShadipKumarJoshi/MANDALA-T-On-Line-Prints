import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/dashboard_Tab_View_Heading.dart';
import 'package:final_assignment/features/customize/presentation/viewmodel/customize_view_model.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:final_assignment/features/sell/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cart/domain/entity/cart_entity.dart';

class CustomizeView extends ConsumerStatefulWidget {
  const CustomizeView({super.key});

  @override
  ConsumerState<CustomizeView> createState() => _CustomizeViewState();
}

class _CustomizeViewState extends ConsumerState<CustomizeView> {
  final _customizeFormKey = GlobalKey<FormState>();

  // Variables to hold selected values
  ProductEntity? _selectedCategory;
  String? _selectedSize;
  DesignEntity? _selectedDesign;
  String? _selectedColor;

  // Dropdown options

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];
  final Map<String, String> _designs = {
    'Design 1': 'assets/designs/design1.jpg',
    'Mario': 'assets/designs/mario.jpeg',
  };

  final colors = {
    'Black': Colors.black,
    'White': Colors.white,
    'Grey': Colors.grey,
    'Blue': Colors.blue,
    'Red': Colors.red,
    'Green': Colors.green,
    'Yellow': Colors.yellow,
    'Purple': Colors.purple,
    'Pink': Colors.pink,
  };

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(customizeViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customizeViewModelProvider);
    return SizedBox.expand(
      child: Column(
        children: [
          const Center(
            child: DashboardTabViewHeading(text: 'Customize Prints'),
          ),
          // Top container displaying selected images and background color
          Expanded(
            child: Container(
              height: 300,
              color: _selectedColor != null
                  ? colors[_selectedColor]
                  : Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Display the selected category image if available
                  if (_selectedCategory != null)
                    Image.network(
                      "${ApiEndpoints.productImage}/${_selectedCategory!.productImage}",
                      fit: BoxFit.contain,
                    ),
                  // Overlay the selected design image if available
                  if (_selectedDesign != null)
                    Image.network(
                      '${ApiEndpoints.designImage}/${_selectedDesign!.designImage}',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _customizeFormKey,
                  child: Column(
                    children: [
                      // Category Dropdown with Images
                      DropdownButtonFormField<ProductEntity>(
                        value: _selectedCategory,
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                        items: state.products.map((entry) {
                          return DropdownMenuItem<ProductEntity>(
                            value: entry,
                            child: Row(
                              children: [
                                Image.network(
                                    "${ApiEndpoints.productImage}${entry.productImage}",
                                    width: 24,
                                    height: 24),
                                const SizedBox(width: 10),
                                Text(entry.productCategory),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a category' : null,
                      ),
                      const SizedBox(height: 5),

                      // Size Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedSize,
                        decoration: const InputDecoration(labelText: 'Size'),
                        items: _selectedCategory == null
                            ? []
                            : _selectedCategory!.productSize.map((String size) {
                                print(size);
                                return DropdownMenuItem<String>(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSize = newValue;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a size' : null,
                      ),
                      const SizedBox(height: 5),

                      // Design Dropdown
                      DropdownButtonFormField<DesignEntity>(
                        value: _selectedDesign,
                        decoration: const InputDecoration(labelText: 'Design'),
                        items: state.designs.map((DesignEntity design) {
                          return DropdownMenuItem<DesignEntity>(
                            value: design,
                            child: Text(design.designName),
                          );
                        }).toList(),
                        onChanged: (DesignEntity? newValue) {
                          setState(() {
                            _selectedDesign = newValue;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a design' : null,
                      ),
                      const SizedBox(height: 5),

                      // Color Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedColor,
                        decoration: const InputDecoration(labelText: 'Color'),
                        items: _selectedCategory == null
                            ? []
                            : _selectedCategory?.productColor
                                .map((String color) {
                                return DropdownMenuItem<String>(
                                  value: color,
                                  child: Text(color),
                                );
                              }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedColor = newValue;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a color' : null,
                      ),
                      const SizedBox(height: 5),

                      // Add to Cart Button
                      ElevatedButton(
                        onPressed: () {
                          if (_customizeFormKey.currentState!.validate()) {
                            final quantity = 1;
                            final customizePrice =
                                _selectedDesign!.designPrice +
                                    _selectedCategory!.productPrice;
                            final total = quantity * customizePrice;
                            // Add your add-to-cart logic here
                            ref
                                .read(customizeViewModelProvider.notifier)
                                .addToCart(CartEntity(
                                    productEntity: _selectedCategory!,
                                    designEntity: _selectedDesign!,
                                    quantity: quantity,
                                    productSize: _selectedSize!,
                                    productColor: _selectedColor!,
                                    customizePrice: customizePrice,
                                    total: total));
                          }
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
