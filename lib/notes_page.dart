import 'package:flutter/material.dart';
import 'package:notes_app/add_note_page.dart';
import 'package:notes_app/notes_class.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<NotesClass> _notes = [
    NotesClass("prueba 1", "texto aqui"),
    NotesClass("Este Titulo es Grande", "Cantidad1 de texto "),
    NotesClass("Probando titulos grandes para textos grandes",
        "Cantidad1 de texto maximo que entra "),
    NotesClass("Probando titulos grandes para textos grandes",
        "Cantidad1 de texto maximo que entra "),
    NotesClass("Probando titulos grandes para textos grandes",
        "Cantidad1 de texto maximo que entra "),
    NotesClass("Probando titulos grandes para textos grandes",
        "Cantidad1 de texto maximo que entra "),
    NotesClass("Probando titulos grandes para textos grandes",
        "Cantidad1 de texto maximo que entra "),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: const Center(
          child: Icon(
            Icons.note_sharp,
            color: Colors.orange,
            size: 35.0,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.search,
                          size: 35.0,
                          color: Colors.white24,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Buscar notas",
                          style: TextStyle(
                            color: Colors.white24,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(children: [
                      for (var notes in _notes)
                        Note(title: notes.title, text: notes.text)
                    ]),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      children: const [
                        Note(
                          title: "tecto cortito",
                          text:
                              "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto",
                        ),
                        SizedBox(height: 10.0),
                        Note(
                          title: "Este titulo es grande",
                          text: "Lorem Ipsum es simplemente el texto de relleo",
                        ),
                        Note(
                          title: "tecto cortito",
                          text:
                              "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto",
                        ),
                        SizedBox(height: 10.0),
                        Note(
                          title: "Este titulo es grande",
                          text: "Lorem Ipsum es simplemente el texto de relleo",
                        ),
                        SizedBox(height: 10.0),
                        Note(
                          title: "Este titulo es grande",
                          text: "Lorem Ipsum es simplemente el texto de relleo",
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const AddNotePage())));
        },
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          size: 35.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Note extends StatefulWidget {
  final String title;
  final String text;
  const Note({super.key, required this.title, required this.text});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            active = !active;
          });
        },
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 14.0,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "11 de septiembre",
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  active
                      ? const Icon(
                          Icons.verified,
                          color: Colors.white,
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
