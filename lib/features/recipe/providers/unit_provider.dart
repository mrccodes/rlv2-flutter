import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';
import 'package:rlv2_flutter/features/recipe/providers/unit_service_provider.dart';

class UnitState {
  UnitState({
    this.units = const [],
    this.isLoading = false,
    this.error,
  });

  UnitState copyWith({
    List<Unit>? units,
    bool? isLoading,
    String? error,
  }) {
    return UnitState(
      units: units ?? this.units,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  final List<Unit> units;
  final bool isLoading;
  final String? error;
}

class UnitNotifier extends StateNotifier<UnitState> {
  UnitNotifier(this.ref) : super(UnitState());
  final Ref ref;

  List<Unit> get units => state.units;

  bool get isLoading => state.isLoading;

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void clearUnits() {
    state = state.copyWith(units: []);
  }

  Future<void> loadUnits({bool forceLoad = false}) async {
    if (state.units.isNotEmpty && !forceLoad) return;
    state = state.copyWith(isLoading: true);
    try {
      final units = await ref.read(unitServiceProvider).getUnits();

      // Step 1: Group units by label
      final unitsByLabel = <String, List<Unit>>{};

      // Populate the map with labels as keys and corresponding units as values
      for (final unit in units) {
        if (!unitsByLabel.containsKey(unit.label)) {
          unitsByLabel[unit.label] = [];
        }
        unitsByLabel[unit.label]!.add(unit);
      }

      // Step 2: Create a list of updated units, differentiating duplicates
      final updatedUnits = units.map((unit) {
        final unitsWithSameLabel = unitsByLabel[unit.label]!;

        // If duplicates exist, append the system to the label
        if (unitsWithSameLabel.length > 1) {
          return Unit(
            id: unit.id,
            type: unit.type,
            value: unit.value,
            abbreviation: unit.abbreviation,
            label: '${unit.label} (${unit.system})', // Append system to label
            system: unit.system,
          );
        } else {
          // No duplicates, return the unit unchanged
          return unit;
        }
      }).toList();

      // Step 3: Update the state with the updated list of units
      state = state.copyWith(units: updatedUnits);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final unitProvider = StateNotifierProvider<UnitNotifier, UnitState>(
  UnitNotifier.new,
);
