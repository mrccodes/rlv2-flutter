import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rlv2_flutter/core/widgets/custom_button.dart';
import 'package:rlv2_flutter/utils/validators.dart';

class CreateAccountForm extends ConsumerStatefulWidget {
  const CreateAccountForm({super.key, this.onCreateAccount});

  final Future<void> Function({
    required bool isOrganizationAccount,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
    required String organizationName,
    required String organizationDescription,
    required String organizationImage,
  })? onCreateAccount;

  @override
  CreateAccountFormState createState() => CreateAccountFormState();
}

class CreateAccountFormState extends ConsumerState<CreateAccountForm> {
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  bool isOrganizationAccount = false;
  File? _organizationImageFile;
  File? _userImageFile;
  String email = '';
  String password = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String organizationName = '';
  String organizationDescription = '';
  String organizationImage = '';

  Future<void> _pickOrganizationImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _organizationImageFile = File(pickedFile.path);
        organizationImage = pickedFile.path;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No image selected'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _removeOrganizationImageFile() {
    setState(() {
      _organizationImageFile = null;
      organizationImage = '';
    });
  }

  void _removeUserImageFile() {
    setState(() {
      _userImageFile = null;
      organizationImage = '';
    });
  }

  Future<void> createAccount() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await widget.onCreateAccount?.call(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          username: username,
          isOrganizationAccount: isOrganizationAccount,
          organizationName: organizationName,
          organizationDescription: organizationDescription,
          organizationImage: organizationImage,
        );
      } catch (err) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.toString())),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable content
        SingleChildScrollView(
          padding: const EdgeInsets.only(
              bottom: 100), // Add bottom padding to avoid button overlap
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => email = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password *',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => password = value!,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => firstName = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => lastName = value!,
                ),
                const SizedBox(height: 16),
                if (_userImageFile != null) ...[
                  Image.file(
                    _userImageFile!,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _removeUserImageFile,
                    child: const Text('Remove Image'),
                  ),
                ] else ...[
                  Row(
                    children: [
                      Text(
                        'User Image',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        onPressed: () =>
                            _pickOrganizationImage(ImageSource.gallery),
                        text: 'Choose Image',
                        buttonType: ButtonType.secondary,
                      ),
                    ],
                  ),
                ],
                SwitchListTile(
                  title: const Text('Create account for organization?'),
                  value: isOrganizationAccount,
                  onChanged: (bool value) {
                    setState(() {
                      isOrganizationAccount = value;
                    });
                  },
                ),
                if (isOrganizationAccount) ...[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Organization Name *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => organizationName = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Organization Description',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => organizationDescription = value!,
                  ),
                  const SizedBox(height: 16),
                  if (_organizationImageFile != null) ...[
                    Image.file(
                      _organizationImageFile!,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _removeOrganizationImageFile,
                      child: const Text('Remove Image'),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Text(
                          'Organization Image',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 16),
                        CustomButton(
                          onPressed: () =>
                              _pickOrganizationImage(ImageSource.gallery),
                          text: 'Choose Image',
                          buttonType: ButtonType.secondary,
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),

        // Fixed Button at the bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: createAccount,
                child: const Text('Create Account'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
