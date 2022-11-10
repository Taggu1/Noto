import 'dart:ui';

import 'package:colorpicker_flutter/colorpicker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/color_utils.dart';
import 'package:note_app/core/utils/string.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:o_color_picker/o_color_picker.dart';

import '../../../../core/models/hive_offset.dart';
import '../../../../core/painter/painter.dart';
import '../../../../core/widgets/buttons/custom_elevated_button.dart';
import '../../../../core/widgets/custom_iconbutton_widget.dart';
import '../widgets/drawing_widget.dart';
import '../widgets/form_widget.dart';

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
  String dt = DateTime.now().toIso8601String();
  String id = DateTime.now().microsecondsSinceEpoch.toString();
  Color noteColor = getRandomColor();

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

          noteColor = note.color!.toMaterialColor();
          id = note.id!;
          dt = note.time!;
          oldDrawing = note.drawing;
          oldPoints = note.points;
        }
      }
      _loaded = true;
    }
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();

  void _add() async {
    if (withDrawing) {
      final drawinfDetails = _painterController.finish();

      drawing = await drawinfDetails.toPNG();
    }
    if (_formKey.currentState!.validate()) {
      final Note newNote = Note(
        title: _titleController.text,
        body: _bodyController.text,
        id: id,
        time: dt,
        color: noteColor.toString(),
        drawing: withDrawing != false ? drawing : oldDrawing,
        points: withDrawing != false
            ? _painterController.getMapOfOffsets()
            : oldPoints,
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
            icon: Icons.delete,
            buttonColor: Colors.red,
            onPressed: () {
              _removeWidget(noteIndex!);
            },
          ),
        CustomIconButton(
          onPressed: _showColorsDialog,
          icon: Icons.color_lens,
          iconColor: noteColor,
        ),
        if (widget.isAdd == true)
          CustomIconButton(
            onPressed: () {
              _add();
            },
            icon: Icons.add,
            buttonColor: Colors.green,
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
              selectedColor: noteColor,
              colors: primaryColorsPalette,
              onColorChange: (color) {
                setState(() {
                  noteColor = color;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
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
