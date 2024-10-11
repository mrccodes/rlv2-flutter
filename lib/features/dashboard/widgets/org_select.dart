import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/providers/user_organizations_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class OrgSelect extends ConsumerStatefulWidget {
  const OrgSelect({super.key});

  @override
  ConsumerState<OrgSelect> createState() => _OrgSelectState();
}

class _OrgSelectState extends ConsumerState<OrgSelect> {
  String? _selectedOrganization;

  @override
  void initState() {
    super.initState();
    _selectedOrganization = 'Personal Recipes';
  }

  @override
  Widget build(BuildContext context) {
    final organizations = ref.watch(userOrganizationsProvider);
    final orgOptions = organizations.data.map((org) {
      return DropdownMenuItem<String>(
        value: org
            .id, // Assuming organization id is a String or can be converted to one
        child: Text(org.organizationName),
      );
    }).toList();

    if (organizations.isLoading) {
      return const CircularProgressIndicator();
    } 

    if (organizations.error != null) {
      return Text(organizations.error!);
    }

    AppLogger.info('OrgSelect: ${organizations.data}');

    if (orgOptions.isEmpty) {
      return Text(_selectedOrganization!);
    }

    return DropdownButton<String>(
      value: _selectedOrganization,
      items: orgOptions,
      onChanged: (String? newValue) {
        setState(() {
          _selectedOrganization = newValue;
        });
      },
      isExpanded: true,
    );
  }
}
