import 'package:uuid/uuid.dart';

import '../../features/note/domain/entities/folder.dart';

const kHabitBoxName = 'habits';

const kNotesBoxName = 'notes';

const kTasksBoxName = 'tasks';

const kThemeBoxName = 'theme';

const kFolderBoxName = 'folders';

final kAllFolder = Folder(
  folderName: 'All',
  id: const Uuid().v4(),
);

const kEmailPattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
