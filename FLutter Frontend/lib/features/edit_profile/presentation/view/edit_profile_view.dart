import 'dart:io';

import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/edit_profile/presentation/state/current_state_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/edit_profile_view_model.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  bool isEditing = false;
  File? _image;
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  late TextEditingController phoneController;

  late TextEditingController emailController;

  String? gender = 'male';

  _populateControllers() async {
    await ref.read(editProfileViewModelProvider.notifier).fetchCurrentUser();
    final userState = ref.read(editProfileViewModelProvider);
    if (userState.authEntity != null) {
      firstNameController.text = userState.authEntity!.fullName ?? '';
      lastNameController.text = userState.authEntity!.userName ?? '';

      phoneController.text = userState.authEntity!.phoneNumber ?? '';
      emailController.text = userState.authEntity!.email ?? '';
      // setState(() {}); // Trigger a rebuild to reflect the changes
    }
  }

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    phoneController = TextEditingController();

    emailController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateControllers();
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();

    phoneController.dispose();

    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(editProfileViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Profile' : 'User Profile'),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => isEditing = true),
            )
        ],
      ),
      body: userState.authEntity == null
          ? const Center(child: CircularProgressIndicator())
          : _buildProfileForm(userState),
    );
  }

  Widget _buildProfileForm(CurrentProfileState userState) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildNameFields(),
                    _buildEmailField(),
                    _buildPhoneField(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (isEditing) ...[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => setState(() => isEditing = false),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final user = AuthEntity(
                                    fullname: firstNameController.text,
                                    username: lastNameController.text,
                                    phoneNumber: phoneController.text,
                                    email: emailController.text,
                                    password: "");
                                // ref
                                //     .read(editProfileViewModelProvider.notifier)
                                //     .updateUser(user);
                                setState(() => isEditing = false);
                              }
                            },
                            child: const Text('Save Changes'),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            label: 'Full Name',
            controller: firstNameController,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextField(
            label: 'username',
            controller: lastNameController,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return _buildTextField(
      label: 'Email',
      enabled: false,
      controller: emailController,
    );
  }

  Widget _buildPhoneField() {
    return _buildTextField(
      label: 'Phone',
      enabled: false,
      controller: phoneController,
    );
  }

  Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gender',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: ['Male', 'Female'].map((String value) {
              return Expanded(
                child: RadioListTile<String>(
                  title:
                      Text(value, style: const TextStyle(color: Colors.black)),
                  value: value.toLowerCase(),
                  groupValue: gender,
                  onChanged: isEditing
                      ? (String? newValue) {
                          setState(() => gender = newValue!);
                        }
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: suffixIcon,
        ),
        enabled: enabled && isEditing,
        validator: (value) => value!.isEmpty ? 'This field is required' : null,
      ),
    );
  }
}
