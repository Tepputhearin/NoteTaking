import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}): super(key: key);
  
  final QueryDocumentSnapshot doc;
  
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.doc["note_title"]);
    _contentController = TextEditingController(text: widget.doc["note_content"]);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _updateNote() {
    widget.doc.reference.update({
      "note_title": _titleController.text,
      "note_content": _contentController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _updateNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: AppStyle.mainTitle,
              decoration: InputDecoration(
              border: InputBorder.none,),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
            const SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: _contentController,
              style: AppStyle.mainContent,
              maxLines: null,
              decoration: InputDecoration(
              border: InputBorder.none,), 
            ),
          ],
        ),
      ),
    );
  }
}
