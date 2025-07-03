import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 24),
          ListTile(leading: Icon(Icons.lightbulb_outline), title: Text('Нотатки')),
          ListTile(leading: Icon(Icons.notifications_none), title: Text('Нагадування')),
          ListTile(leading: Icon(Icons.label_outline), title: Text('Редагувати мітки')),
          ListTile(leading: Icon(Icons.archive_outlined), title: Text('Архів')),
          ListTile(leading: Icon(Icons.delete_outline), title: Text('Кошик')),
        ],
      ),
    );
  }
}