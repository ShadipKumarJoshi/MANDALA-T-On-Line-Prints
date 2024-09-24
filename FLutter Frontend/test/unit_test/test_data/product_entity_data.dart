import 'package:final_assignment/features/sell/domain/entity/product_entity.dart';

class ProductTestData {
  ProductTestData._();

  static List<ProductEntity> getProductTestData() {
    List<ProductEntity> lstProducts = [
      const ProductEntity(
        id: "66be396fce824f47a6dad0e4",
        productCategory: "T-shirt",
        productPrice: 199,
        productSize: ["XS,S,M,L,XL,XXL"],
        productColor: ["Black,White,Grey,Blue,Red,Green,Yellow,Purple,Pink"],
        productDescription: "dssd",
        productImage: "1718626169288-skating  einstein.jpeg",
        createAt: '2024-08-15T17:20:21.378Z',
      ),
      const ProductEntity(
        id: "66be39a9ce824f47a6dad0f0",
        productCategory: "T-shirt",
        productPrice: 199,
        productSize: ["XS,S,M,L,XL,XXL"],
        productColor: ["Black,White,Grey,Blue,Red,Green,Yellow,Purple,Pink"],
        productDescription: "ddssd",
        productImage: "1718626169288-skating  einstein.jpeg",
        createAt: '2024-08-15T17:20:21.378Z',
      ),
    ];
    return lstProducts;
  }
}
