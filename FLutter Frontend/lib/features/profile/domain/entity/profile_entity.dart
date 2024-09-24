import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? id;
  final String? fullName;
  final String? userName;
  final String? phoneNumber;
  final String? email;
  final String? userAddress;
  final String? userOptionalAddress;
  final String? userImage;

  const ProfileEntity({
    this.id,
    required this.fullName,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.userAddress,
    required this.userOptionalAddress,
    required this.userImage,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        userName,
        phoneNumber,
        email,
        userAddress,
        userOptionalAddress,
        userImage,
      ];

  get password => null;
}
