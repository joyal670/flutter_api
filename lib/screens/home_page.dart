import 'package:api_reference/screens/add_edit_note.dart';
import 'package:api_reference/screens/note_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: SafeArea(
          child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        children: List.generate(
            10,
            (index) => NoteItem(
                id: index.toString(),
                title: 'Lospe',
                description: 'lospswhbfjh')),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return AddNoteScreen(
              type: ActionType.addNote,
            );
          })));
        },
        label: Text('click here'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
