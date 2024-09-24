import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_assignment/core/common/colors.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:final_assignment/features/profile/presentation/widgets/profile_menu.dart';
import 'package:final_assignment/features/profile/presentation/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(profileViewmodelProvider.notifier).initialize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewmodelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // close the current screen and return to the previous one
          },
        ),
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/dashboard_bg.jpg'), // Replace with your background image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const ProfilePic(),
                const SizedBox(height: 20),

                // Add profile details here
                Column(
                  children: [
                    Text(profileState.authEntity?.userName ?? 'test123'),
                    Text(profileState.authEntity?.fullName ?? 'Test Test'),
                    Text(profileState.authEntity?.email ?? 'test@test.com'),
                    Text(profileState.authEntity?.phoneNumber ?? '9876543210'),
                  ],
                ),

                ProfileMenu(
                  text: "Edit Profile",
                  icon: Icons.person,
                  press: () {
                    if (mounted) {
                      ref
                          .read(profileViewmodelProvider.notifier)
                          .openEditProfileView();
                    }
                  },
                ),

                ProfileMenu(
                  text: "Change Password",
                  icon: Icons.lock,
                  press: () {
                    // Navigate to Settings screen
                  },
                ),
                // ProfileMenu(
                //   text: "Enable Finger Print",
                //   icon: "assets/icons/fingerprint.svg",
                //   press: () {
                //     if (mounted) {
                //       ref
                //           .read(profileViewmodelProvider.notifier)
                //           .enableFingerprint();
                //     }
                //   },
                // ),
                ProfileMenu(
                  text: "Your Orders",
                  icon: Icons.shopping_cart,
                  press: () {
                    ref.read(profileViewmodelProvider.notifier).openOrderView();
                  },
                ),
                ProfileMenu(
                  text: "Log Out",
                  icon: Icons.logout,
                  press: () {
                    if (mounted) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        title: 'Logout',
                        desc: 'Are You Sure You Want To Logout?',
                        btnOkOnPress: () {
                          if (mounted) {
                            ref
                                .read(profileViewmodelProvider.notifier)
                                .logout();
                          }
                        },
                        btnCancelOnPress: () {},
                      ).show();
                    }
                  },
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: TextButton(
                //     style: TextButton.styleFrom(
                //       foregroundColor: Colors.blueAccent,
                //       padding: const EdgeInsets.all(20),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(15)),
                //       backgroundColor: Colors.blueAccent.withOpacity(0.2),
                //     ),
                //     onPressed: () {},
                //     child: Row(
                //       children: [
                //         SvgPicture.asset(
                //           "assets/icons/dark_mode.svg",
                //           width: 22,
                //         ),
                //         const SizedBox(width: 20),
                //         const Expanded(child: Text("Dark Mode/Light Mode")),
                //         Switch(
                //           value: true,
                //           onChanged: (value) {
                //             value = !value;
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
