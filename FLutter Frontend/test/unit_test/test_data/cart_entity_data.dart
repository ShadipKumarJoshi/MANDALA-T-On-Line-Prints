import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:final_assignment/features/sell/domain/entity/product_entity.dart';

class CartTestData {
  CartTestData._();

  static List<CartEntity> getCartTestData() {
    List<CartEntity> lstCarts = [
      const CartEntity(
        id: "667d4b0a36e7f16457399758",
        productEntity: ProductEntity(
          id: "667d4b0a36e7f16457399758",
          productCategory: 'electronics',
          productPrice: 33,
          productSize: ['small', 'medium', 'large'],
          productColor: ['red', 'blue', 'green'],
          productDescription: "ss",
          productImage: "1718671882095-skating  einstein.jpeg",
          createAt: "2024-06-18T00:44:50.816Z",
          
        ),
        designEntity: DesignEntity(
          id: "667d4b0a36a7f16457399758",
          designName: "tdd",
          designPrice: 33,
          designCategory: 'electronics',
          designDescription: "ss",
          designImage: "1718671882095-skating  einstein.jpeg",
          createdAt: "2024-06-18T00:44:50.816Z",
          createdBy: "666fedddda29c2977fc846e5",
          
        ),
        quantity: 1,
        productSize: 'small',
        productColor: 'red',
        customizePrice: 33,
        total: 33,
      ),
      const CartEntity(
        id: "667d4b0aw6e7f16457399758",
        productEntity: ProductEntity(
          id: "667d4b0a36e7f16457399758",
          productCategory: 'electronics',
          productPrice: 33,
          productSize: ['small', 'medium', 'large'],
          productColor: ['red', 'blue', 'green'],
          productDescription: "ss",
          productImage: "1718671882095-skating  einstein.jpeg",
          createAt: "2024-06-18T00:44:50.816Z",
          
        ),
        designEntity: DesignEntity(
          id: "667d4b0a36e7f16457399758",
          designName: "tdd",
          designPrice: 33,
          designCategory: 'electronics',
          designDescription: "ss",
          designImage: "1718671882095-skating  einstein.jpeg",
          createdAt: "2024-06-18T00:44:50.816Z",
          createdBy: "666fedddda29c2977fc846e5",
          
        ),
        quantity: 1,
        productSize: 'small',
        productColor: 'red',
        customizePrice: 33,
        total: 33,

        
      
        
      ),
    ];
    return lstCarts;
  }
}
