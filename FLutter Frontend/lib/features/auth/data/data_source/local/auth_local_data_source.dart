import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/local/hive_service.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalDataSourceProvider = Provider(
  (ref) => AuthLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(authHiveModelProvider),
  ),
);

class AuthLocalDataSource {
  final HiveService _hiveService;
  final AuthHiveModel _authHiveModel;

  AuthLocalDataSource(this._hiveService, this._authHiveModel);

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      final hiveUser = _authHiveModel.toHiveModel(user);

      // Check if user with the same email exists
      final userByEmail = await _hiveService.getUserByEmail(hiveUser.email);
      if (userByEmail.email.isNotEmpty) {
        return Left(Failure(error: 'Email is already registered!'));
      }

      // Check if user with the same phoneNumber exists
      final userByPhoneNumber = await _hiveService.getUserByPhoneNumber(hiveUser.phoneNumber);
      if (userByPhoneNumber.phoneNumber.isNotEmpty) {
        return Left(Failure(error: 'Phone number is already registered!'));
      }

      // final userByEmail = await _hiveService.getUserByEmail(hiveUser.email);
      // if (userByEmail!.email.isNotEmpty) {
      //   return Left(Failure(error: 'User Already Exists'));
      // }

      // if (userByEmail != null) {
      //   return Left(Failure(error: 'Email is already registered!'));
      // }
      //If already email throw error
      // final userByEmail = await _hiveService.getUserByEmail(user.email);
      // if (userByEmail!.email.isNotEmpty) {
      //   return Left(Failure(error: 'User already exist'));
      // }

      // If neither email nor phone exists, proceed with adding the user
      await _hiveService.addUser(_authHiveModel.toHiveModel(user));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Future<Either<Failure, bool>> loginUser(
  //   String email,
  //   String password,
  // ) async {
  //   try {
  //     AuthHiveModel? users =
  //         await _hiveService.login(email: email, password: password);
  //     return const Right(true);
  //   } catch (e) {
  //     return Left(Failure(error: e.toString()));
  //   }
  // }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      // Attempt login with email
      AuthHiveModel? user =
          await _hiveService.login(email: email, password: password);

      // If no user found by email, attempt login with phoneNumber number
      user ??= await _hiveService.login(phoneNumber: email, password: password);

      // Check if login was successful
      if (user!.email.isEmpty) {
        return Left(Failure(error: 'Invalid credentials'));
      }

      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
