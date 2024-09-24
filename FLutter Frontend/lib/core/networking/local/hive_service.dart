import 'package:final_assignment/app/constants/hive_table_constant.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

// Service class to handle Hive operations
class HiveService {
  // Initialize Hive and register adapters
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters for Hive models
    // Hive.registerAdapter(ProductHiveModelAdapter());
    // Hive.registerAdapter(DesignHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // // ======================== Product Queries ========================
  // Future<void> addProduct(ProductHiveModel product) async {
  //   var box = await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
  //   await box.put(product.productId, product);
  // }

  // Future<List<ProductHiveModel>> getAllProducts() async {
  //   var box = await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
  //   var products = box.values.toList();
  //   return products;
  // }

  // // ======================== Design Queries ========================
  // Future<void> addDesign(DesignHiveModel design) async {
  //   var box = await Hive.openBox<DesignHiveModel>(HiveTableConstant.designBox);
  //   await box.put(design.designId, design);
  // }

  // Future<List<DesignHiveModel>> getAllDesigns() async {
  //   var box = await Hive.openBox<DesignHiveModel>(HiveTableConstant.designBox);
  //   var designs = box.values.toList();
  //   box.close();
  //   return designs;
  // }

  // Add a user to the Hive box
  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  // Get all users from the Hive box
  Future<List<AuthHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }

  // Login method supporting both email and phoneNumber
  Future<AuthHiveModel?> login(
      {String? email, String? phoneNumber, required String password}) async {
    var box = await Hive.openBox<AuthHiveModel>(
        HiveTableConstant.userBox); // Open the Hive box that contains user data

    //   var user = box.values.firstWhere(
    //       (element) => element.email == email && element.password == password);
    //   box.close();
    //   return user;
    // }

    // Declare a variable to store the user if found
    AuthHiveModel? user;

    // Check if the login attempt is with an email
    if (email != null) {
      // Try to find a user with the matching email and password
      user = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => AuthHiveModel.empty(), // Return null if no user found
      );
    }
    // Check if the login attempt is with a phoneNumber number
    else {
      // Try to find a user with the matching phoneNumber and password
      user = box.values.firstWhere(
        (element) => element.phoneNumber == phoneNumber && element.password == password,
        orElse: () => AuthHiveModel.empty(), // Return null if no user found
      );
    }

    // Return the found user or null if no user was found
    return user;
  }

// Get user by email
  Future<AuthHiveModel> getUserByEmail(String email) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
      (element) => element.email == email,
      orElse: () => AuthHiveModel.empty(),
    );
    return user;
  }

// Get user by phone
  Future<AuthHiveModel> getUserByPhoneNumber(String phoneNumber) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
      (element) => element.phoneNumber == phoneNumber,
      orElse: () => AuthHiveModel.empty(),
    );
    return user;
  }
}
