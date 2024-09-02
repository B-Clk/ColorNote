import 'db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

List<NoteData> notlar = [];

class _NotesPageState extends State<NotesPage> {

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    final data = await DatabaseHelper().getNotes();
    setState(() {
      notlar = data;
    });
  }

  void _addNote(String baslik, String yazi) async {
    final note = NoteData(baslik: baslik, yazi: yazi);
    await DatabaseHelper().insertNote(note);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController _baslikController = TextEditingController();
              TextEditingController _notController = TextEditingController();

              return AlertDialog(
                backgroundColor: Colors.pinkAccent,
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                        _addNote(_baslikController.text, _notController.text);
                      });
                    },
                    child: Text("Ekle", style: TextStyle(color: Colors.white)),
                  )
                ],
                title: Text("Not Ekle", style: TextStyle(fontSize: 22, color: Colors.white)),
                content: SizedBox(
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Başlık", style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                      CupertinoTextField(controller: _baslikController),
                      SizedBox(height: 5),
                      Text("Not", style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                      CupertinoTextField(
                        controller: _notController,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(CupertinoIcons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: notlar.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      title: Text(notlar[index].baslik, style: TextStyle(color: Colors.white)),
                      content: Text(notlar[index].yazi, style: TextStyle(color: Colors.white)),
                    );
                  },
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.greenAccent,
                child: Center(
                  child: Text(notlar[index].baslik, style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class NoteData {
  final int? id;
  final String baslik;
  final String yazi;

  NoteData({this.id, required this.yazi, required this.baslik});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'baslik': baslik,
      'yazi': yazi,
    };
  }
}
