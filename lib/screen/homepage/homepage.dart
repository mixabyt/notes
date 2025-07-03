import 'package:flutter/material.dart';
import 'sidebarmenu.dart';
import 'notesmainview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keep"),
        leading: Icon(Icons.menu),
        actions: [
          Flexible(
            child: TextField(
              
              decoration: InputDecoration(
                hintText: 'Пошук',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.refresh),
          const SizedBox(width: 16),
          const Icon(Icons.settings),
          const SizedBox(width: 16),
          const CircleAvatar(child: Text('А')),
        ],
        
      ),
      body: Row(
        children: const [
          SidebarMenu(),
          Expanded(
            child: NotesMainView(),
          )
        ],
      ),
    );
  }
}