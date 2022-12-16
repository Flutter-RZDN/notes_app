import 'package:flutter/material.dart';

import 'package:notes_app/services/provider_status.dart';
import 'package:notes_app/view/note_detail_page.dart';
import 'package:provider/provider.dart';

import 'widget/note_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    statusProvider.getNotes();
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: statusProvider.isSelected
          ? AppBar(
              title: Text(
                  "${statusProvider.deleteNotes.length.toString()} Elementos Seleccionados"),
              centerTitle: true,
              backgroundColor: Colors.black54,
              leading: InkWell(
                onTap: () {
                  statusProvider.setIsSelected();
                  statusProvider.removeAllNotesOfListDeleteNotes();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            )
          : AppBar(
              title: Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Image.asset("lib/assets/nota-adhesiva.png"),
                  ),
                ),
              ),
              actions: const [
                Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                  size: 30.0,
                ),
              ],
              elevation: 0,
              backgroundColor: Colors.black54,
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
            //   child: Container(
            //     height: 45.0,
            //     decoration: BoxDecoration(
            //       color: Colors.white10,
            //       borderRadius: BorderRadius.circular(40.0),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //       child: Row(
            //         children: const [
            //           Icon(
            //             Icons.search,
            //             size: 35.0,
            //             color: Colors.white24,
            //           ),
            //           SizedBox(
            //             width: 5.0,
            //           ),
            //           Text(
            //             "Buscar notas",
            //             style: TextStyle(
            //               color: Colors.white24,
            //               fontSize: 14.0,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20.0,
            // ),
            statusProvider.notes.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      itemCount: statusProvider.notes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 140,
                      ),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Note(
                            notesClass: statusProvider.notes[index],
                          ),
                        );
                      }),
                    ),
                  )
                : const Center(
                    child: Text(
                      "Agrega una nota",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: statusProvider.isSelected
          ? Container()
          : FloatingActionButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const NoteDetailPage(
                            notesClass: null,
                          ))),
                );
              },
              backgroundColor: Colors.orange,
              child: const Icon(
                Icons.add,
                size: 35.0,
                color: Colors.white,
              ),
            ),
      bottomNavigationBar: statusProvider.isSelected
          ? Container(
              height: 80,
              color: Colors.white10,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 5,
              ),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    if (statusProvider.deleteNotes.isNotEmpty) {
                      statusProvider.deleteAllNotes();
                      statusProvider.setIsSelected();
                    }
                  },
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                      child: Image.asset(
                        "lib/assets/bin.png",
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(
              height: 1,
            ),
    );
  }
}
