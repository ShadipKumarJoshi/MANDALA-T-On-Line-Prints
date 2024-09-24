import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';

class OrderTestData {
  OrderTestData._();

  static List<OrderEntity> getOrderTestData() {
    List<OrderEntity> lstOrders = [
      const OrderEntity(
        id: "66bcd0a2447dfe38b1f255a0",
    userId : "667b8f903c3c31b4be842032",
    carts: [],
    total: 200,
    address: "Kathmandu",
    paymentType: "Cash on Delivery",
      ),
      const OrderEntity(
    id: "66bcd0a2447dfe38b1f255a1",
    userId : "667b8f903c3c31b4be842032",
    carts: [],
    total: 300,
    address: "Lalitpur",
    paymentType: "Cash on Delivery",
  ),
      
    ];
    return lstOrders;
  }
}
