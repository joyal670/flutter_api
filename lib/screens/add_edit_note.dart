import 'package:api_reference/data/data.dart';
import 'package:api_reference/model/create_note_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

enum ActionType { addNote, editNote }

class AddNoteScreen extends StatelessWidget {
  final ActionType type;
  String? noteId;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  AddNoteScreen({super.key, required this.type, this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      NoteDb().createNote(note);
    }
  }
}
