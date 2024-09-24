import 'package:final_assignment/features/design/domain/entity/design_entity.dart';

class DesignTestData {
  DesignTestData._();

  static List<DesignEntity> getDesignTestData() {
    List<DesignEntity> lstDesigns = [
      const DesignEntity(
        id: "66702779dcf772a7a339fbdd",
        designName: "test 1",
        designPrice: 199,
        designCategory: 'plants',
        designDescription: "dssd",
        designImage: "1718626169288-skating  einstein.jpeg",
        createdAt: "2024-06-17T12:08:50.242Z",
        createdBy: "666fee0dda29c2977fc846e8",
      ),
      const DesignEntity(
        id: "66702991dcf772a7a339fc0b",
        designName: "test 2",
        designPrice: 324,
        designCategory: 'plants',
        designDescription: "dfdsgdfg",
        designImage: "dfdsgdfg",
        createdAt: "22024-06-17T12:08:50.242Z",
        createdBy: "666fee0dda29c2977fc846e8",
      ),
      const DesignEntity(
        id: "6670da0a36e7f16457399758",
        designName: "tdd",
        designPrice: 33,
        designCategory: 'electronics',
        designDescription: "ss",
        designImage: "1718671882095-skating  einstein.jpeg",
        createdAt: "2024-06-18T00:44:50.816Z",
        createdBy: "666fedddda29c2977fc846e5",
      ),
    ];
    return lstDesigns;
  }
}
