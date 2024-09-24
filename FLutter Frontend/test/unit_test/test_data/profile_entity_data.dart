import 'package:final_assignment/features/profile/domain/entity/profile_entity.dart';

class ProfileTestData {
  ProfileTestData._();

  static ProfileEntity getProfileTestData() {
    return const ProfileEntity(
        fullName: "Test Seven",
        userName: "test7",
        phoneNumber: "9876543217",
        email: "test7@test.com",
        userAddress: "Hello",
        userOptionalAddress: "Hooo",
        userImage: "1719468470742-plague_docto.jpg");
  }
}
