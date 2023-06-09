import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/core/constants/strings.dart';
import 'package:note_app/core/data_sources/local_data_source.dart';

import '../../domain/entities/folder.dart';

part 'folder_state.dart';

class FolderCubit extends Cubit<FolderState> {
  final LocalDataSource<Folder> localDataSource;
  FolderCubit({required this.localDataSource})
      : super(
          FolderState(
            folders: [kAllFolder],
            currentName: 'All',
          ),
        );

  void addFolder({required Folder folder}) async {
    await localDataSource.addItem(item: folder);
    fetchFolders();
  }

  void removeFolder({required Folder folder}) async {
    await localDataSource.removeItem(itemId: folder.id);
    fetchFolders();
  }

  void fetchFolders() async {
    final folders = await localDataSource.fetchItems();

    emit(
      FolderState(
        folders: [kAllFolder, ...folders],
        currentName: state.currentName,
      ),
    );
  }

  void changeCurrentFolder({required String folderName}) {
    emit(
      FolderState(
        folders: state.folders,
        currentName: folderName,
      ),
    );
  }
}
