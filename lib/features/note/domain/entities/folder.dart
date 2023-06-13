import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'folder.g.dart';

@HiveType(typeId: 7)
class Folder extends Equatable {
  @HiveField(0)
  final String folderName;

  @HiveField(1)
  final String id;

  const Folder({
    required this.folderName,
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
        folderName,
      ];
}
