import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';

String formatUnit(Unit unit, int qty) {
  var s = qty > 1 ? 's' : '';
  s = unit.label == 'inch' && qty > 1 ? 'es' : s;
  var label = unit.label.toLowerCase();
  if (label == 'foot') {
    label = 'feet';
    s = '';
  }

  return '$label$s';
}
