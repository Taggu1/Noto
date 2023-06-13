import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Item extends Equatable {
  final String id;

  Item() : id = const Uuid().v4();

  @override
  List<Object?> get props => [id];
}
