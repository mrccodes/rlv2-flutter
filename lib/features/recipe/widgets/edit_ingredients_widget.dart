import 'dart:async'; // Import this for Timer
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/core/widgets/dropdown_button_form_field_widget.dart';
import 'package:rlv2_flutter/core/widgets/loading_widget.dart';
import 'package:rlv2_flutter/core/widgets/text_form_field_widget.dart';
import 'package:rlv2_flutter/features/recipe/models/create_simple_ingredient_item_model.dart';
import 'package:rlv2_flutter/features/recipe/models/create_simple_ingredient_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_simple_ingredients_with_ingredient.dart';
import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';
import 'package:rlv2_flutter/features/recipe/providers/unit_provider.dart';
import 'package:rlv2_flutter/features/recipe/utils/format_ingredient.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';
import 'package:rlv2_flutter/utils/capitalize_string.dart';
import 'package:rlv2_flutter/utils/widget_handle_error.dart';

class EditIngredientWidget extends ConsumerStatefulWidget {
  const EditIngredientWidget({
    required this.existingIngredients,
    required this.onExistingIngredientDeleted,
    required this.onNewIngredientsUpdated,
    super.key,
  });

  final List<RecipeVersionSimpleIngredientsWithData> existingIngredients;
  final ValueChanged<List<CreateSimpleIngredientItem>> onNewIngredientsUpdated;
  final ValueChanged<RecipeVersionSimpleIngredientsWithData>
      onExistingIngredientDeleted;

  @override
  EditIngredientWidgetState createState() => EditIngredientWidgetState();
}

class EditIngredientWidgetState extends ConsumerState<EditIngredientWidget> {
  late TextEditingController _ingredientController;
  late TextEditingController _unitController;
  late TextEditingController _quantityController;

  final _ingredientFormKey = GlobalKey<FormState>();
  final List<CreateSimpleIngredientItem> newIngredients = [];
  final apiService = ApiService();
  List<CreateSimpleIngredient> _suggestions = [];
  CreateSimpleIngredient?
      _selectedIngredient; // This holds the selected suggestion
  Timer? _debounce; // Timer for debouncing
  bool suggesstionsLoading = false;
  Unit? _selectedUnit;
  bool unitsLoading = false;

  @override
  void initState() {
    super.initState();
    _ingredientController = TextEditingController();
    _unitController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    _selectedIngredient = null;
    _selectedUnit = null;
    _ingredientController.dispose();
    _unitController.dispose();
    _quantityController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Debounced function to fetch ingredient suggestions
  void _onSearchChanged(String query) {
    _selectedIngredient = null;
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (query.isNotEmpty) {
        _fetchIngredientSuggestions(query);
      }
    });
  }

  Future<void> _fetchIngredientSuggestions(String query) async {
    try {
      setState(() {
        suggesstionsLoading = true;
      });
      final response = await apiService.getRequest<dynamic>(
        '/simpleIngredients/search',
        (data) => data,
        queryParams: {
          'query': query,
        },
      );

      setState(() {
        AppLogger.info('Fetched ingredient suggestions $response');
        _suggestions =
            ((response as Map<String, dynamic>)['foods'] as List<dynamic>)
                .map(
                  (item) => CreateSimpleIngredient(
                    name:
                        (item as Map<String, dynamic>)['description'] as String,
                    brand: item['brandName'] as String?,
                    origin: item['marketCountry'] as String?,
                  ),
                )
                .toList();
      });
    } catch (e) {
      if (mounted) {
        widgetHandleError(e, context);
      }
    }
    setState(() {
      suggesstionsLoading = false;
    });
  }

  void _addNewIngredient() {
    if (_ingredientFormKey.currentState!.validate() &&
        _selectedIngredient != null) {
      final newSimpleIngredient = CreateSimpleIngredientItem(
        ingredient: CreateSimpleIngredient(
          name: _ingredientController.text,
          brand: _selectedIngredient!.brand,
          origin: _selectedIngredient!.origin,
        ),
        quantity: double.parse(_quantityController.text),
        unit: _selectedUnit!,
      );

      setState(() {
        newIngredients.add(newSimpleIngredient); // Use the selected ingredient
        _selectedIngredient = null; // Clear the selection after adding
      });

      widget.onNewIngredientsUpdated(newIngredients);
      _ingredientController.clear();
      _suggestions.clear();
    }
  }

  void _onExistingIngredientDeleted(
    RecipeVersionSimpleIngredientsWithData ingredient,
  ) {
    setState(() {
      widget.existingIngredients.remove(ingredient);
      widget.onExistingIngredientDeleted(ingredient);
    });
  }

  void _onNewIngredientDeleted(CreateSimpleIngredientItem ingredient) {
    setState(() {
      newIngredients.remove(ingredient);
      widget.onNewIngredientsUpdated(newIngredients);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Now ref is available directly inside build
    final units = ref.watch(unitProvider).units;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.existingIngredients.isNotEmpty || newIngredients.isNotEmpty)
          Text(
            'Swipe to delete ingredients',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        if (widget.existingIngredients.isNotEmpty || newIngredients.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.existingIngredients.length,
            itemBuilder: (context, index) {
              final ingredient = widget.existingIngredients[index];
              return Dismissible(
                key: ValueKey(ingredient.simpleIngredient.name),
                onDismissed: (direction) =>
                    _onExistingIngredientDeleted(ingredient),
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(ingredient.simpleIngredient.name),
                ),
              );
            },
          ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: newIngredients.length,
          itemBuilder: (context, index) {
            final ingredient = newIngredients[index];
            return Dismissible(
              key: ValueKey(ingredient),
              onDismissed: (direction) => _onNewIngredientDeleted(ingredient),
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(
                  formatIngredient(
                    ingredient.quantity,
                    ingredient.unit,
                    ingredient.ingredient.name,
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Ingredient '
            '${widget.existingIngredients.length + newIngredients.length + 1}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Form(
          key: _ingredientFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldWidget(
                controller: _ingredientController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search for an ingredient...',
                  labelText: 'Ingredient name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) => value != null && value.trim().isEmpty
                    ? 'Please enter an ingredient'
                    : null,
              ),
              if (_suggestions.isEmpty &&
                  !suggesstionsLoading &&
                  _selectedIngredient != null)
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                            bottom: 8,
                          ),
                          child: TextFormFieldWidget(
                            controller: _quantityController,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) =>
                                value != null && value.trim().isEmpty
                                    ? 'Please enter a quantity'
                                    : null,
                          ),
                        ),
                        if (unitsLoading || units.isEmpty)
                          const LoadingWidget()
                        else
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              top: 8,
                              bottom: 8,
                            ),
                            child: DropdownButtonFormFieldWidget(
                              decoration: const InputDecoration(
                                labelText: 'Unit',
                              ),
                              value: _selectedUnit?.label,
                              items: Unit.toDropdownMenuItems(units),
                              onChanged: (value) {
                                _selectedUnit = value as Unit?;
                              },
                              validator: (value) =>
                                  value == null ? 'Please select a unit' : null,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              if (suggesstionsLoading)
                LinearProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )
              else if (_suggestions.isNotEmpty && !suggesstionsLoading)
                Text(
                  'Select an ingredient from the list below',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  radius: const Radius.circular(8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      final name = capitalize(suggestion.name.toLowerCase());

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIngredient =
                                  suggestion; // Set the selected ingredient
                              _ingredientController.text =
                                  capitalize(suggestion.name.toLowerCase());
                              _suggestions.clear();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(.2),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ), // Style for the ingredient name
                                ),
                                if (suggestion.brand != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      'Brand: ${capitalize(
                                        suggestion.brand!.toLowerCase(),
                                      )}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ), // Style for brand name
                                    ),
                                  ),
                                if (suggestion.origin != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      'Origin: ${capitalize(
                                        suggestion.origin!.toLowerCase(),
                                      )}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ), // Style for origin
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _addNewIngredient, // Call the method directly
          icon: const Icon(Icons.add),
          label: const Text('Add Ingredient'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
