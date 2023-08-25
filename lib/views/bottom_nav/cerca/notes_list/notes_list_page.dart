import 'package:flutter/material.dart';

import 'package:student_link/services/notes/request_note.dart';
import 'package:student_link/widgets/note/note_box_style/note_box_style.dart';
import 'package:student_link/models/notes/note.dart';

class NotesListPage extends StatefulWidget {
  NotesListPage({Key? key}) : super(key: key);

  @override
  _NotesListPageState createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  int page = 0;
  List<Note> notes = [];
  bool isLoading = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          !isLoading) {
        _loadData();
      }
    });
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Note>? newNotes = await RequestListNote.getNotes(context, page);
      if (newNotes != null && newNotes.isNotEmpty) {
        setState(() {
          notes.addAll(newNotes);
          page++;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false; // No more data to load
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle the error, e.g., by showing a message
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: notes.length + (isLoading ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == notes.length) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return NoteBoxStyle(notes[index]);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
