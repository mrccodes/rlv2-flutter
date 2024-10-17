import 'package:flutter/material.dart';

class Unit {
  Unit({
    required this.id,
    required this.label,
    required this.value,
    required this.system,
    required this.type,
    this.abbreviation,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] as String,
      label: json['label'] as String,
      value: json['value'] as String,
      abbreviation: json['abbreviation'] as String?,
      system: json['system'] as String,
      type: json['type'] as String,
    );
  }

  final String id;
  final String label;
  final String value;
  final String system;
  final String type;
  final String? abbreviation;

  static List<DropdownMenuItem<Unit>> toDropdownMenuItems(List<Unit> units) {
    return units
        .map(
          (unit) => DropdownMenuItem<Unit>(
            value: unit,
            child: Text(unit.label),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'value': value,
      'abbreviation': abbreviation,
      'system': system,
      'type': type,
    };
  }
}
