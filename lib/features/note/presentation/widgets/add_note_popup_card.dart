import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/color_utils.dart';
import 'package:note_app/core/utils/string.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:painter/painter.dart';

import '../../../../core/widgets/custom_iconbutton_widget.dart';
import 'custom_text_field.dart';
import 'drawing_widget.dart';
import 'form_widget.dart';

class EditAddNotePage extends StatefulWidget {
  static const routeName = "/edit-add-note-page";
  const EditAddNotePage({Key? key}) : super(key: key);

  @override
  State<EditAddNotePage> createState() => _EditAddNotePageState();
}

class _EditAddNotePageState extends State<EditAddNotePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  bool withDrawing = false;
  bool? isAdd;
  int? noteIndex;
  bool _loaded = false;
  Color color = getRandomColor();
  String dt = DateTime.now().toIso8601String();
  String id = DateTime.now().microsecondsSinceEpoch.toString();
  Uint8List? oldDrawing;
  bool? canScrool;
  late PainterController _painterController;

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
      final args = ModalRoute.of(context)!.settings.arguments as List;
      isAdd = args[0] as bool;
      if (args.length > 1) {
        noteIndex = args.last;
      }
      if (isAdd == false) {
        final state = BlocProvider.of<NoteBloc>(context).state;
        if (state is LoadedNoteState) {
          final note = state.notes[noteIndex!];
          print(noteIndex);
          _titleController.text = note.title!;
          _bodyController.text = note.body!;

          color = note.color!.toMaterialColor();
          id = note.id!;
          dt = note.time!;
          oldDrawing = note.drawing;
        }
      }
      _loaded = true;
    }
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();

  void _add() async {
    Uint8List? drawing;
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
          color: color.toString(),
          drawing: withDrawing != false ? drawing : oldDrawing);
      BlocProvider.of<NoteBloc>(context).add(
        EditOrAddNoteEvent(
            note: newNote,
            addOrEdit: isAdd == false ? FunType.edit : FunType.add,
            index: isAdd == false ? noteIndex! : null),
      );
      BlocProvider.of<NoteBloc>(context).add(FetchNotesEvent());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: kBlackColor,
        appBar: _buildAppbar(context),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: kBlackColor,
      elevation: 0,
      leading: CustomIconButton(
        icon: Icons.arrow_back,
        onPressed: () {
          if (isAdd == false) {
            _add();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      actions: [
        if (isAdd == true)
          CustomIconButton(
            onPressed: () {
              _add();
            },
            icon: Icons.add,
            buttonColor: Colors.green,
          ),
        CustomIconButton(
            onPressed: () {
              setState(() {
                withDrawing = !withDrawing;
              });
            },
            icon: Icons.draw),
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
}
