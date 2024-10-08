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
    required String userImage,
    required String organizationName,
    required String organizationDescription,
    required String organizationImage,
  })? onCreateAccount;

  @override
  CreateAccountFormState createState() => CreateAccountFormState();
}

class CreateAccountFormState extends ConsumerState<CreateAccountForm> {
  final formKey = GlobalKey<FormState>();
  final validators = StringValidators();
  final ImagePicker _picker = ImagePicker();
  String email = '';
  String password = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String userImage = '';
  bool isOrganizationAccount = false;
  String organizationName = '';
  String organizationDescription = '';
  String organizationImage = '';
  File? _organizationImageFile;
  File? _userImageFile;

  String? _firstNameValidator(String? value) {
    if (value!.isNotEmpty) {
      final firstNameValidators = <Validator>[
        validators.firstNameLengthLong,
        validators.firstNameNumber,
        validators.firstNameSymbol,
        validators.firstNameSpace,
      ];

      for (final validator in firstNameValidators) {
        if (!validator.validate(value)) {
          return validator.error;
        }
      }
    }
    return null;
  }

  String? _lastNameValidator(String? value) {
    if (value!.isNotEmpty) {
      final lastNameValidators = <Validator>[
        validators.lastNameLengthLong,
        validators.lastNameNumber,
        validators.lastNameSymbol,
        validators.lastNameSpace,
      ];

      for (final validator in lastNameValidators) {
        if (!validator.validate(value)) {
          return validator.error;
        }
      }
    }
    return null;
  }

  String? _usernameValidator(String? value) {
    if (value!.isNotEmpty) {
      final usernameValidators = <Validator>[
        validators.usernameLengthLong,
        validators.usernameLengthShort,
        validators.usernameSymbol,
      ];

      for (final validator in usernameValidators) {
        if (!validator.validate(value)) {
          return validator.error;
        }
      }
    }
    return null;
  }

  String? _emailValidator(String? value) {
    final emailValidators = <Validator>[
      validators.emailNotEmpty,
      validators.emailIsValid,
    ];

    for (final validator in emailValidators) {
      if (!validator.validate(value!)) {
        return validator.error;
      }
    }
    return null;
  }

  String? _organizationNameValidator(String? value) {
    if (isOrganizationAccount) {
      final organizationNameValidators = <Validator>[
        validators.organziationNameNotEmpty,
        validators.organizationNameLengthLong,
        validators.organizationNameSymbol,
      ];

      for (final validator in organizationNameValidators) {
        if (!validator.validate(value!)) {
          return validator.error;
        }
      }
    }
    return null;
  }

  String? _organizationDescriptionValidator(String? value) {
    if (isOrganizationAccount && value!.isNotEmpty) {
      final organizationDescriptionValidators = <Validator>[
        validators.organizationDescriptionLengthLong,
        validators.organizationDescriptionSymbol,
      ];

      for (final validator in organizationDescriptionValidators) {
        if (!validator.validate(value)) {
          return validator.error;
        }
      }
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    final passwordValidators = <Validator>[
      validators.passwordNotEmpty,
      validators.passwordLengthShort,
      validators.passwordLengthLong,
      validators.passwordNumber,
      validators.passwordSymbol,
    ];

    for (final validator in passwordValidators) {
      if (!validator.validate(value!)) {
        return validator.error;
      }
    }
    return null;
  }

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
  Future<void> _pickUserImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _userImageFile = File(pickedFile.path);
        userImage = pickedFile.path;
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
      _organizationImageFile = null;
      userImage = '';
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
          userImage: userImage,
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
    return Form(
      key: formKey,
      child: Expanded(
        child: ListView(
        children: [
          TextFormField(
            validator: _emailValidator,
            decoration: const InputDecoration(
              labelText: 'Email *',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => email = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _passwordValidator,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password *',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => password = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _firstNameValidator,
            decoration: const InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => firstName = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _lastNameValidator,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => lastName = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _usernameValidator,
            decoration: const InputDecoration(
              labelText: 'Username',
              helperText: 'Automatically generated if left blank',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => username = value!,
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
                Text(
                  'User Image', // Label for image
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 16), // Spacing between text and button
                Row(children: [
                CustomButton(
                  onPressed: () => _pickUserImage(ImageSource.gallery),
                  text: 'Choose from gallery',
                  buttonType: ButtonType.secondary,
                ),
                const SizedBox(width: 16),
                CustomButton(
                  onPressed: () => _pickUserImage(ImageSource.camera),
                  text: 'Take image',
                  buttonType: ButtonType.secondary,
                ),

                ],)
          ],
          const SizedBox(height: 16),
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
              validator: _organizationNameValidator,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Organization Description',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => organizationDescription = value!,
              validator: _organizationDescriptionValidator,
            ),
            const SizedBox(height: 16),
            // Display image or show the button to pick an image
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
                  Text(
                    'Organization Image', // Label for image
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16), // Spacing between text and button
                  Row(
                    children: [
                      CustomButton(
                    onPressed: () =>
                        _pickOrganizationImage(ImageSource.gallery),
                    text: 'Choose From Gallery',
                    buttonType: ButtonType.secondary,
                  ),
                  const SizedBox(width: 16),
                  CustomButton(
                    onPressed: () =>
                        _pickOrganizationImage(ImageSource.camera),
                    text: 'Take Image',
                    buttonType: ButtonType.secondary,
                  ),
                    ],
                  )
                  
            ],
          ],
          const SizedBox(height: 16),
          SizedBox(
              width: double.infinity, // Make the button full width
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                child: Text('Submit'),
              ),
            ),
        ],
      ),
      ),
    );
  }
}
