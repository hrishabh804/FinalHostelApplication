import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/model/floors.dart';
import 'package:hostel_project/pages/rooms_page.dart';
import 'package:hostel_project/services/floor_firebase_firestore.dart';
import 'package:hostel_project/ui/floor_screen.dart';


// ignore: must_be_immutable
class FloorList extends StatefulWidget {
  FloorList({this.uid,this.name,this.adminEmail,this.college});
  String uid;
  String name;
  String adminEmail;
  String college;
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return _FloorListState();
  }

}

class _FloorListState extends State<FloorList> {
  List<Floors> items;
  FloorFirestoreService db = new FloorFirestoreService();


  StreamSubscription<QuerySnapshot>floorsSub;

  @override
  void initState() {
    super.initState();

    items = new List();

    floorsSub?.cancel();
    floorsSub = db.getFloorList(widget.college).listen((QuerySnapshot snapshot) {
      final List<Floors> floors = snapshot.documents
          .map((documentSnapshot) => Floors.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = floors;
      });
    });
  }

  @override
  void dispose() {
    floorsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLOORS'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Dismissible(
                  key: ObjectKey(items[position]),
                  background: stackBehindDismiss(),
                  child:Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '${items[position].title}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${items[position].description}',
                          style: new TextStyle(
                          ),
                        ),
                        leading: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(0.0)),
                            CircleAvatar(
                              child: Icon(
                                  Icons.hotel
                              ),
                            ),
                          ],
                        ),
                        onLongPress: () => _navigateToFloors(context, items[position]),
                        onTap: ()=> _navigateToRooms(context,items[position].title),
                      ),

                    ],
                  ),
                  confirmDismiss: (direction) {
                    _showDialog(context,items[position],position);
                    return null;

                  }
              );

            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createNewFloors(context),

      ),
    );
  }

  void _deleteFloors(BuildContext context, Floors floors, int position) async {
    db.deleteFloor(floors.id).then((floors) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToFloors(BuildContext context, Floors floors) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FloorPage(floors)),
    );
  }

  void _createNewFloors(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FloorPage(Floors(null, '', widget.college))),
    );
  }
  _navigateToRooms(BuildContext context, String floor) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=>RoomList(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college,floor:floor)));
  }
  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
  void _showDialog(var error, Floors item,int pos) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("DELETE"),
          content: new Text("ARE YOU SURE"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("YES"),
              onPressed: () {
                _deleteFloors(context, item, pos);
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );


  }
}

