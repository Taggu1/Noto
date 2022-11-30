import 'dart:ui';

import 'package:colorpicker_flutter/colorpicker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/core/constants/blank_canvas.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/color_utils.dart';
import 'package:note_app/core/utils/string.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/models/hive_offset.dart';
import '../../../../core/painter/painter.dart';
import '../../../../core/widgets/buttons/custom_elevated_button.dart';
import '../../../../core/widgets/custom_iconbutton_widget.dart';
import '../widgets/drawing_widget.dart';
import '../widgets/form_widget.dart';

import 'dart:io' show File, Platform;

class EditAddNotePage extends StatefulWidget {
  static const routeName = "/edit-add-note-page";
  final int noteIndex;
  final bool isAdd;
  const EditAddNotePage(
      {Key? key, required this.noteIndex, required this.isAdd})
      : super(key: key);

  @override
  State<EditAddNotePage> createState() => _EditAddNotePageState();
}

class _EditAddNotePageState extends State<EditAddNotePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  late PainterController _painterController;
  String _dt = DateTime.now().toIso8601String();
  String _id = DateTime.now().microsecondsSinceEpoch.toString();
  String? _externalImagePath = null;
  Color _noteColor = getRandomColor();

  bool withDrawing = false;
  bool _loaded = false;

  int? noteIndex;
  Uint8List? oldDrawing;
  bool? canScrool;
  Uint8List? drawing;
  Map<HiveOffset, Map<String, dynamic>>? oldPoints;

  @override
  void initState() {
    super.initState();
    _painterController = PainterController()
      ..thickness = 5.0
      ..backgroundColor = kBlackColor
      ..drawColor = Colors.teal;
  }

  @override
  void didChangeDependencies() {
    if (_loaded == false) {
      if (!widget.isAdd) {
        noteIndex = widget.noteIndex;
        final state = BlocProvider.of<NoteBloc>(context).state;
        if (state is LoadedNoteState) {
          final note = state.notes[noteIndex!];
          if (note.points != null) {
            _painterController.setOldPaint(note.points!);
          }
          _titleController.text = note.title!;
          _bodyController.text = note.body!;

          _noteColor = note.color!.toMaterialColor();
          _id = note.id!;
          _dt = note.time!;
          _externalImagePath = note.externalImagePath;
          oldDrawing = note.drawing;
          oldPoints = note.points;
        }
      }
      _loaded = true;
    }
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _add() async {
    if (withDrawing) {
      final drawinfDetails = _painterController.finish();
      if (drawinfDetails.picture.approximateBytesUsed > 232) {
        drawing = await drawinfDetails.toPNG();
      }
    }

    if (_formKey.currentState!.validate()) {
      final Note newNote = Note(
        title: _titleController.text,
        body: _bodyController.text,
        id: _id,
        time: _dt,
        color: _noteColor.toString(),
        drawing: withDrawing != false ? drawing : oldDrawing,
        points: withDrawing != false
            ? _painterController.getMapOfOffsets()
            : oldPoints,
        externalImagePath: _externalImagePath,
      );
      _sendDataToNoteBloc(newNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _buildAppbar(context),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      leading: CustomIconButton(
        icon: Icons.arrow_back,
        onPressed: () {
          if (widget.isAdd == false) {
            _add();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      actions: [
        if (!widget.isAdd)
          CustomIconButton(
            icon: Entypo.trash,
            onPressed: () {
              _removeWidget(noteIndex!);
            },
          ),
        if (widget.isAdd == true)
          CustomIconButton(
            onPressed: () {
              _add();
            },
            icon: Icons.add,
          ),
        CustomIconButton(
          onPressed: _showColorsDialog,
          icon: Icons.colorize,
          iconColor: _noteColor,
        ),
        if (!Platform.isIOS && !Platform.isWindows)
          CustomIconButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              _externalImagePath = image?.path;
            },
            icon: Icons.image,
          ),
        CustomIconButton(
          onPressed: () {
            setState(
              () {
                withDrawing = !withDrawing;
              },
            );
          },
          icon: Icons.draw,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        if (withDrawing) ...[
          FormWidget(
            formKey: _formKey,
            titleController: _titleController,
            withBody: false,
          ),
          Expanded(
            child: DrawingWidget(
              painterController: _painterController,
            ),
          ),
        ],
        if (!withDrawing)
          Expanded(
            child: SingleChildScrollView(
              child: FormWidget(
                formKey: _formKey,
                titleController: _titleController,
                bodyController: _bodyController,
                withBody: true,
              ),
            ),
          ),
      ],
    );
  }

  _sendDataToNoteBloc(Note newNote) {
    BlocProvider.of<NoteBloc>(context).add(
      EditOrAddNoteEvent(
          note: newNote,
          addOrEdit: widget.isAdd == false
              ? NoteFunctionType.edit
              : NoteFunctionType.add,
          index: widget.isAdd == false ? noteIndex! : null),
    );
    BlocProvider.of<NoteBloc>(context).add(FetchNotesEvent());
    Navigator.of(context).pop();
  }

  _showColorsDialog() {
    return showDialog<void>(
      context: context,
      builder: (_) => Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OColorPicker(
              selectedColor: _noteColor,
              colors: primaryColorsPalette,
              onColorChange: (color) {
                setState(() {
                  _noteColor = color;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  _exitPage() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Do you wanna save this note",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          CustomElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _add();
            },
            child: const Text("Yes"),
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  }

  _removeWidget(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Do you wanna delete this note",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          CustomElevatedButton(
            onPressed: () {
              BlocProvider.of<NoteBloc>(context)
                  .add(RemoveNoteEvent(noteIndex: index));
              BlocProvider.of<NoteBloc>(context).add(FetchNotesEvent());
              Navigator.pushReplacementNamed(context, "/");
            },
            child: Text("Yes"),
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _painterController.dispose();
    super.dispose();
  }
}
