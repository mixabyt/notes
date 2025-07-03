import 'package:flutter/material.dart';

class NotesMainView extends StatelessWidget {
  const NotesMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: NotesGrid()), 
      ],
    );
  }
}

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = List.generate(20, (index) => 'Нотатка $index');

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
        itemBuilder: (context, index) => NoteCard(text: notes[index]),
      ),
    );
  }
}


class NoteCard extends StatelessWidget {
  final String text;

  const NoteCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(text, maxLines: 10, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}


