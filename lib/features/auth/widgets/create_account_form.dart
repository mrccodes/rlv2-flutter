import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rlv2_flutter/core/widgets/custom_button.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';
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
        validators.usernameSpace,
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

  String? _confirmPasswordValidator(String? value) {
    if (value != password) {
      return context.l10n.passwordsDoNotMatchError;
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
            content: Text(context.l10n.noImageSelectedError),
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
    final l10n = context.l10n;

    return Form(
      key: formKey,
      child: Expanded(
        child: ListView(
        children: [
          TextFormField(
            validator: _emailValidator,
            decoration: InputDecoration(
              labelText: '${l10n.emailFieldLabel} *',
              border: const OutlineInputBorder(),
            ),
            onSaved: (value) => email = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _passwordValidator,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '${l10n.passwordFieldLabel} *',
              border: const OutlineInputBorder(),
            ),
            onSaved: (value) => password = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _confirmPasswordValidator,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '${l10n.confirmPasswordFieldLabel} *',
              border: const OutlineInputBorder(),
            ),
            onSaved: (value) => password = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _firstNameValidator,
            decoration: InputDecoration(
              labelText: l10n.firstNameFieldLabel,
              border: const OutlineInputBorder(),
            ),
            onSaved: (value) => firstName = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _lastNameValidator,
            decoration: InputDecoration(
              labelText: l10n.lastNameFieldLabel,
              border: const OutlineInputBorder(),
            ),
            onSaved: (value) => lastName = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _usernameValidator,
            decoration: InputDecoration(
              labelText: l10n.usernameFieldLabel,
              helperText: l10n.usernameHelperText,
              border: const OutlineInputBorder(),
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
              child: Text(l10n.removeImageButtonLabel),
            ),
          ] else ...[            
                Text(
                  l10n.userImageFieldLabel, // Label for image
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 16), // Spacing between text and button
                Row(children: [
                CustomButton(
                  onPressed: () => _pickUserImage(ImageSource.gallery),
                  text: l10n.chooseImageFromGalleryButtonLabel,
                  buttonType: ButtonType.secondary,
                ),
                const SizedBox(width: 16),
                CustomButton(
                  onPressed: () => _pickUserImage(ImageSource.camera),
                  text: l10n.takeImageButtonLabel,
                  buttonType: ButtonType.secondary,
                ),

                ],)
          ],
          const SizedBox(height: 16),
          SwitchListTile(
            title: Text(l10n.orgImageFieldLabel),
            value: isOrganizationAccount,
            onChanged: (bool value) {
              setState(() {
                isOrganizationAccount = value;
              });
            },
          ),
          if (isOrganizationAccount) ...[
            TextFormField(
              decoration: InputDecoration(
                labelText: '${l10n.orgNameFieldLabel} *',
                border: const OutlineInputBorder(),
              ),
              onSaved: (value) => organizationName = value!,
              validator: _organizationNameValidator,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.orgDescriptionFieldLabel,
                border: const OutlineInputBorder(),
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
                child: Text(l10n.removeImageButtonLabel),
              ),
            ] else ...[
                  Text(
                    l10n.orgImageFieldLabel, 
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16), // Spacing between text and button
                  Row(
                    children: [
                      CustomButton(
                    onPressed: () =>
                        _pickOrganizationImage(ImageSource.gallery),
                    text: l10n.chooseImageFromGalleryButtonLabel,
                    buttonType: ButtonType.secondary,
                  ),
                  const SizedBox(width: 16),
                  CustomButton(
                    onPressed: () =>
                        _pickOrganizationImage(ImageSource.camera),
                    text: l10n.takeImageButtonLabel,
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
                onPressed: createAccount,
                child: Text(l10n.submitButtonLabel), // Button text
              ),
            ),
        ],
      ),
      ),
    );
  }
}
