import 'package:api_reference/data/data.dart';
import 'package:api_reference/model/create_note_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

enum ActionType { addNote, editNote }

class AddNoteScreen extends StatelessWidget {
  final ActionType type;
  String? noteId;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _scaffoldkey = GlobalKey();

  AddNoteScreen({super.key, required this.type, this.noteId});

  @override
  Widget build(BuildContext context) {
    if (type == ActionType.editNote) {
      if (noteId == null) {
        Navigator.of(context).pop();
      } else {
        final note = NoteDb.instance.getNoteById(noteId!);
        if (note == null) {
          Navigator.of(context).pop();
        } else {
          _titleController.text = note.title ?? 'no title';
          _descriptionController.text = note.content ?? 'no content';
        }
      }
    }
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(type.name.toUpperCase()),
        actions: [saveButton],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter title'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              maxLength: 100,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter description'),
            )
          ],
        ),
      )),
    );
  }

  Widget get saveButton => TextButton.icon(
      onPressed: () {
        switch (type) {
          case ActionType.addNote:
            saveData();
            break;
          case ActionType.editNote:
            break;
        }
      },
      icon: Icon(
        Icons.save,
        color: Colors.white,
      ),
      label: Text(
        'Save',
        style: TextStyle(color: Colors.white),
      ));

  saveData() async {
    final title = _titleController.text;
    final desc = _descriptionController.text;

    if (title == null || desc == null) {
      return;
    } else {
      final note = await CreateNoteResponse(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          content: desc);

      final _note = NoteDb().createNote(note);
      if (_note != null) {
        // MotionToast toast = MotionToast.success(
        //   description: const Text(
        //     'Note Saved',
        //     style: TextStyle(fontSize: 12),
        //   ),
        //   layoutOrientation: ToastOrientation.rtl,
        //   animationType: AnimationType.fromRight,
        //   dismissable: true,
        // );
        // toast.show(_scaffoldkey.currentContext!);
        // Future.delayed(const Duration(seconds: 4)).then((value) {
        //   toast.dismiss();
        // });
        Navigator.of(_scaffoldkey.currentContext!).pop();
      } else {
        // MotionToast toast = MotionToast.error(
        //   description: const Text(
        //     'Something went wrong',
        //     style: TextStyle(fontSize: 12),
        //   ),
        //   layoutOrientation: ToastOrientation.rtl,
        //   animationType: AnimationType.fromRight,
        //   dismissable: true,
        // );
        // toast.show(_scaffoldkey.currentContext!);
        // Future.delayed(const Duration(seconds: 4)).then((value) {
        //   toast.dismiss();
        // });
      }
    }
  }
}
