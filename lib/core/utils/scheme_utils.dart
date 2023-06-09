import 'package:flex_color_scheme/flex_color_scheme.dart';

FlexScheme mapIndexToScheme(int index) {
  return schemesMap[index];
}

final Map schemesMap = {
  0: FlexScheme.rosewood,
  1: FlexScheme.espresso,
  2: FlexScheme.blueWhale,
};
