import 'package:flutter/material.dart';
import 'sidebarmenu.dart';
import 'notesmainview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(

          children: [
            Text("MyNotes"),
            SizedBox(width: 125,),
            Flexible(
              child: SizedBox(
                width: 500,
                child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Пошук',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
              ),
            ),
          ],
        ),
        leading: Icon(Icons.menu),
        actions: [
          // Flexible(
          //   child: 
          // ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                const SizedBox(width: 16),
                const Icon(Icons.refresh),
                const SizedBox(width: 16),
                const Icon(Icons.settings),
                const SizedBox(width: 16),
                const CircleAvatar(child: Text('А')),
                const SizedBox(width: 16),
              ],
            ),
            )
          
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