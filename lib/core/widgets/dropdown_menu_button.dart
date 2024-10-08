import 'package:flutter/material.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';

class DropdownItem {
  DropdownItem({required this.id, required this.label});
  final String id;
  final String label;
}

class DropdownMenuButton extends StatefulWidget {
  const DropdownMenuButton({
    super.key,
    this.initializeFunc, // Function to initialize the list dynamically
    this.staticList, // Static list of values
  });
  final Future<List<DropdownItem>> Function()? initializeFunc;
  final List<DropdownItem>? staticList;

  @override
  State<DropdownMenuButton> createState() => _DropdownMenuButtonState();
}

class _DropdownMenuButtonState extends State<DropdownMenuButton> {
  DropdownItem? dropdownValue;
  List<DropdownItem> list = [];

  @override
  void initState() {
    super.initState();
    initializeDropdown(); // Initialize data based on provided function or list
  }

  Future<void> initializeDropdown() async {
    if (widget.staticList != null) {
      // If a static list is provided, use it
      setState(() {
        list = widget.staticList!;
        dropdownValue = list.isNotEmpty ? list.first : null;
      });
    } else if (widget.initializeFunc != null) {
      // If an initialization function is provided, call it
      final fetchedList = await widget.initializeFunc!();
      setState(() {
        list = fetchedList;
        dropdownValue = list.isNotEmpty ? list.first : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch localized text from context using
    // localization (AppLocalizations, for example)
    final defaultLabel = context.l10n.myRecipesDropdownOption;

    // Create default dropdown item using localized text
    final defaultDropdownItem = DropdownItem(
      id: 'user_recipes',
      label: defaultLabel,
    );

    // Add the default dropdown item to the list (if not already present)
    list = [defaultDropdownItem, ...list];

    return list.isEmpty
        ? const CircularProgressIndicator() // Show loading indicator
        : DropdownButton<DropdownItem>(
            value: dropdownValue ?? defaultDropdownItem,
            onChanged: (DropdownItem? newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items:
                list.map<DropdownMenuItem<DropdownItem>>((DropdownItem value) {
              return DropdownMenuItem<DropdownItem>(
                value: value, // Pass the whole DropdownItem as the value
                child: Text(value.label), // Display the label
              );
            }).toList(),
          );
  }
}
