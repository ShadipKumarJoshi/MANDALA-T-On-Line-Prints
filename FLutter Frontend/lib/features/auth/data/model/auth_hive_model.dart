import 'package:final_assignment/app/constants/hive_table_constant.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullname;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String password;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fullname,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          fullname: '',
          username: '',
          phoneNumber: '',
          email: '',
          password: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: userId,
        fullname: fullname,
        username: username,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        fullname: entity.fullname,
        username: entity.username,
        phoneNumber: entity.phoneNumber,
        email: entity.email,    
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, fullname: $fullname, username: $username, phoneNumber: $phoneNumber, email: $email,   password: $password';
  }
}
