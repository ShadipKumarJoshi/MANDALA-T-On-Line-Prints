import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:flutter/material.dart';

class DesignCard extends StatelessWidget {
  const DesignCard({super.key, required this.designEntity});

  final DesignEntity designEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                '${ApiEndpoints.designImage}${designEntity.designImage}',
                // '${ApiEndpoints.designImage}${petEntity.designImage}',
                fit: BoxFit.cover,
                height: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                designEntity.designName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Rs. ${designEntity.designPrice}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Category: ${designEntity.designCategory}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
