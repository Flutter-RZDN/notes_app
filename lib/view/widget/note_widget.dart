import 'package:flutter/material.dart';
import 'package:notes_app/model/notes_class.dart';
import 'package:notes_app/services/provider_status.dart';
import 'package:notes_app/view/note_detail_page.dart';
import 'package:provider/provider.dart';

class Note extends StatefulWidget {
  final NotesClass notesClass;
  const Note({
    super.key,
    required this.notesClass,
  });

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  bool active = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    return GestureDetector(
      onLongPress: statusProvider.isSelected
          ? () {}
          : () {
              statusProvider.setIsSelected();
              statusProvider.setDeleteNote(widget.notesClass);
            },
      onTap: statusProvider.isSelected
          ? () {
              if (statusProvider.validIsSelected(widget.notesClass.id!)) {
                statusProvider.removeOfListDeleteNote(widget.notesClass.id!);
              } else {
                statusProvider.setDeleteNote(widget.notesClass);
              }
            }
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => NoteDetailPage(
                            notesClass: widget.notesClass,
                          ))));
            },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color(0XFF242424),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
              child: Text(
                widget.notesClass.title!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.notesClass.content!,
                style: const TextStyle(
                  color: Colors.white24,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.notesClass.updateAt!,
                    style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                statusProvider.isSelected
                    ? statusProvider.validIsSelected(widget.notesClass.id!)
                        ? Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
