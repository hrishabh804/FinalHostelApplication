import 'package:flutter/material.dart';
import 'package:hostel_project/model/floors.dart';
import 'package:hostel_project/services/floor_firebase_firestore.dart';


class FloorPage extends StatefulWidget {
  final Floors floors;
  FloorPage(this.floors);

  @override
  State<StatefulWidget> createState() => new _FloorPageState();
}

class _FloorPageState extends State<FloorPage> {
  FloorFirestoreService db = new FloorFirestoreService();

  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.floors.title);
    _descriptionController = new TextEditingController(text: widget.floors.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Floors')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'ENTER FLOOR LEVEL'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _descriptionController,
              enabled: false,
              decoration: InputDecoration(labelText: 'COLLEGE'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.floors.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.floors.id != null) {
                  db
                      .updateFloor(
                      Floors(widget.floors.id, _titleController.text.toUpperCase(), _descriptionController.text.toUpperCase()))
                      .then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  db.createFloors(_titleController.text.toUpperCase(), _descriptionController.text.toUpperCase()).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
