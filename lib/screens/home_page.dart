import 'package:api_reference/data/data.dart';
import 'package:api_reference/screens/add_edit_note.dart';
import 'package:api_reference/screens/note_item.dart';
import 'package:flutter/material.dart';

import '../model/get_all_note_response/datum.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NoteDb.instance.getNote();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: NoteDb.instance.noteNotifier,
              builder: (context, List<Datum> newNote, _) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  padding: const EdgeInsets.all(10),
                  children: List.generate(newNote.length, (index) {
                    final note = NoteDb.instance.noteNotifier.value[index];
                    if (note.id == null) {
                      return const SizedBox();
                    } else {
                      return NoteItem(
                          id: note.id!,
                          title: note.title ?? 'no title',
                          description: note.content ?? 'no content');
                    }
                  }),
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return AddNoteScreen(
              type: ActionType.addNote,
            );
          })));
        },
        label: const Text('click here'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
