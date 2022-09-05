import 'package:flutter/animation.dart';
import 'package:hive/hive.dart';

part 'hive_offset.g.dart';

@HiveType(typeId: 1)
class HiveOffset extends Offset {
  @HiveField(0)
  final double dx;
  @HiveField(1)
  final double dy;

  HiveOffset(this.dx, this.dy) : super(dx, dy);
}

extension OffsetExtention on Offset {
  HiveOffset toHiveOffset() {
    return HiveOffset(dx, dy);
  }
}
