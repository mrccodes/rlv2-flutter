import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';
import 'package:rlv2_flutter/features/user/utils/format_unit.dart';

String formatIngredient(num qty, Unit unit, String name, [int? versionNumber]) {
  final unitStr = formatUnit(unit, qty);
  return '$qty '
      '$unitStr '
      '$name${versionNumber != null ? ' v$versionNumber' : ''}';
}
