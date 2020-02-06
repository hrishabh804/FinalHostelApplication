import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_project/model/rooms.dart';
import 'package:hostel_project/model/update_room_model.dart';
import 'package:hostel_project/services/room_firebase_firestore.dart';

class RoomsPage extends StatefulWidget {
  final Rooms rooms;
  RoomsPage(this.rooms);

  @override
  State<StatefulWidget> createState() => new _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  RoomsFirestoreService db = new RoomsFirestoreService();

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _roomNumberController;
  TextEditingController _maxRoomCapacityNumberController;

  List<String> list ;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.rooms.floorLevel);
    _descriptionController = new TextEditingController(text: widget.rooms.collegeName);
    _roomNumberController = new TextEditingController(text: widget.rooms.roomNumber);
    _maxRoomCapacityNumberController = new TextEditingController(text: (widget.rooms.maxRoomCapacity).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _roomNumberController,
              decoration: InputDecoration(labelText: 'ENTER ROOM NUMBER'),
            ),
            TextField(
              controller: _titleController,
              enabled: false,
              decoration: InputDecoration(labelText: 'FLOOR'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _descriptionController,
              enabled: false,
              decoration: InputDecoration(labelText: 'COLLEGE'),
            ),
            TextField(
              controller:_maxRoomCapacityNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'ENTER ROOM CAPACITY'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.rooms.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.rooms.id != null) {
                  db
                      .updateRooms(
                      UpdateRooms(widget.rooms.id,_roomNumberController.text.toUpperCase(),_descriptionController.text.toUpperCase(),_titleController.text.toUpperCase(),int.parse(_maxRoomCapacityNumberController.text)))
                      .then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  db.createRooms(_descriptionController.text.toUpperCase(),_roomNumberController.text.toUpperCase(),_titleController.text.toUpperCase(),widget.rooms.students,int.parse(_maxRoomCapacityNumberController.text)).then((_) {
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
