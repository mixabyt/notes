import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../services/api_constants.dart';


import '../../model/note.dart';

class NotesMainView extends StatefulWidget {
  const NotesMainView({super.key});

  @override
  State<NotesMainView> createState() => _NotesMainViewState();
}

class _NotesMainViewState extends State<NotesMainView> {
  List<Note> notes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    var dio = Dio();
    Response? response;

    try {
      response = await dio.get(ApiConstants.GetNotesList);
    } catch (ex) {
      print("error: [$ex]");
    }

    if (response == null) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не вдалося підключитися до сервера'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final data = response.data['notes'] as List;
    notes = data.map((json) => Note.fromJson(json)).toList();

    setState(() => isLoading = false);
  }

  Future<void> handleNoteSave(Note updatedNote) async {
  var dio = Dio();
  Response? response;

  try {
    response = await dio.put(
      "${ApiConstants.UpdateNote}/${updatedNote.id}", 
      data: updatedNote.toJson(),
    );
  } catch (e) {
    print("Помилка при оновленні нотатки: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Не вдалося зберегти нотатку'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
 

  if (response.statusCode == 200) {
    setState(() {
      final index = notes.indexWhere((n) => n.id == updatedNote.id);
      if (index != -1) {
        notes[index] = updatedNote;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Нотатку збережено успішно')),
    );

    print("Оновлена нотатка: ${updatedNote.title} — ${updatedNote.content}");
  } else {
    print("Неуспішний код відповіді: ${response.statusCode}");
  }
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : NotesGrid(notes: notes, onSave: handleNoteSave),
        ),
      ],
    );
  }
}

class NotesGrid extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note) onSave;

  const NotesGrid({super.key, required this.notes, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCard(
            text: note.title,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => EditNoteDialog(
                  note: note,
                  onSave: onSave,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const NoteCard({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () => print("prees"),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(text, maxLines: 10, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}

class EditNoteDialog extends StatefulWidget {
  final Note note;
  final void Function(Note updatedNote) onSave;

  const EditNoteDialog({super.key, required this.note, required this.onSave});

  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextField(
        controller: _titleController,
        decoration: const InputDecoration(labelText: 'Заголовок'),
      ),
      content: SizedBox(
        width: 500,
        child: TextField(
          controller: _contentController,
          maxLines: 10,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Зміст нотатки',
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Скасувати'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedNote = Note(
              id: widget.note.id,
              title: _titleController.text,
              content: _contentController.text,
              createdAT: widget.note.createdAT,
              updatedAT: DateTime.now(),
              userID: widget.note.userID,
              isDeleted: widget.note.isDeleted,
            );

            widget.onSave(updatedNote);
            Navigator.of(context).pop();
          },
          child: const Text('Зберегти'),
        ),
      ],
    );
  }
}
