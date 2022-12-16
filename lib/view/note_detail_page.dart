import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/model/notes_class.dart';
import 'package:notes_app/services/notes_service.dart';

class NoteDetailPage extends StatefulWidget {
  final NotesClass? notesClass;
  const NoteDetailPage({super.key, this.notesClass});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  String title = "";
  String content = "";

  bool textValidator(NotesClass? notesClass, String title, String content) {
    if (title.isEmpty && content.isEmpty) {
      return false;
    } else if (notesClass == null && title.isNotEmpty && content.isNotEmpty) {
      return true;
    } else if (notesClass != null && notesClass.content != content ||
        notesClass?.title != title) {
      return true;
    }
    return false;
  }

  void back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black54,
        actions: [
          textValidator(widget.notesClass, title, content)
              ? InkWell(
                  onTap: widget.notesClass != null
                      ? () async {
                          await NotesService.updateNote(
                            NotesClass(
                                widget.notesClass!.id,
                                widget.notesClass!.createAt,
                                DateFormat("d MMMM yyyy")
                                    .format(DateTime.now())
                                    .toString(),
                                title,
                                content),
                          );
                          back();
                        }
                      : () async {
                          await NotesService.insertNote(
                            NotesClass(
                              null,
                              DateFormat("d MMMM yyyy")
                                  .format(DateTime.now())
                                  .toString(),
                              DateFormat("d MMMM yyyy")
                                  .format(DateTime.now())
                                  .toString(),
                              title,
                              content,
                            ),
                          );

                          back();
                        },
                  child: const Icon(
                    Icons.check,
                    size: 30.0,
                  ),
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: Colors.orange,
              initialValue:
                  widget.notesClass != null ? widget.notesClass!.title : null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Titulo",
                hintStyle: TextStyle(
                  color: Colors.white38,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              onTap: () {
                setState(() {
                  if (widget.notesClass != null && title.isEmpty) {
                    title = widget.notesClass!.title.toString();
                  }
                  if (widget.notesClass != null && content.isEmpty) {
                    content = widget.notesClass!.content.toString();
                  }
                });
              },
            ),
            Text(
              widget.notesClass != null
                  ? widget.notesClass!.updateAt.toString()
                  : "",
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 14,
              ),
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              cursorColor: Colors.orange,
              initialValue:
                  widget.notesClass != null ? widget.notesClass!.content : null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Empiece a escribir",
                hintStyle: TextStyle(
                  color: Colors.white38,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  content = value;
                });
              },
              onTap: () {
                setState(() {
                  if (widget.notesClass != null && title.isEmpty) {
                    title = widget.notesClass!.title.toString();
                  }
                  if (widget.notesClass != null && content.isEmpty) {
                    content = widget.notesClass!.content.toString();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
