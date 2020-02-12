import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hostel_project/model/rooms.dart';
import 'package:hostel_project/pages/student_display_page.dart';
import 'package:hostel_project/services/room_firebase_firestore.dart';
import 'package:hostel_project/ui/rooms_screen.dart';


// ignore: must_be_immutable
class AllRoomList extends StatefulWidget {
  AllRoomList({this.uid,this.name,this.adminEmail,this.college, this.floor});
  String uid;
  String name;
  String adminEmail;
  String college;
  String floor;
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return _AllRoomListState();
  }

}

class _AllRoomListState extends State<AllRoomList> {
  List<Rooms> items;
  RoomsFirestoreService db = new RoomsFirestoreService();


  StreamSubscription<QuerySnapshot>roomsSub;

  @override
  void initState() {
    super.initState();

    items = new List();

    roomsSub?.cancel();
    print(widget.college);
    roomsSub = db.getAllRoomList(widget.college).listen((QuerySnapshot snapshot) {
      final List<Rooms> rooms = snapshot.documents
          .map((documentSnapshot) => Rooms.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = rooms;
      });
    });
  }

  @override
  void dispose() {
    roomsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ROOMS'),
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
                      Card(
                        child: ListTile(
                          title: Text(
                            '${items[position].roomNumber}',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,

                            ),
                          ),
                          subtitle:Text(
                            '${items[position].floorLevel}',
                            style: new TextStyle(
                                fontSize: 18
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
                          trailing: Column(
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Text('ROOM CAPACITY:'+' '+'${items[position].maxRoomCapacity}',textAlign: TextAlign.end,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
                              Text('ALLOCATED:'+' '+'${items[position].students.length}',textAlign: TextAlign.end,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300)),
                              Text('REMAINING:'+' '+'${items[position].maxRoomCapacity-items[position].students.length}',textAlign: TextAlign.end,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300))


                            ],
                          ),
                          onTap: () => _navigateToStudent(context, items[position].roomNumber, items[position].floorLevel,items[position].maxRoomCapacity),
                          onLongPress: ()=> _navigateToRooms(context,items[position]),
                        ),

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
    );
  }

  void _deleteRooms(BuildContext context, Rooms rooms, int position) async {
    db.deleteRooms(rooms.id).then((rooms) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToRooms(BuildContext context, Rooms rooms) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoomsPage(rooms)),
    );
  }
  List<String> list = [];

  void _createNewRooms(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoomsPage(Rooms(null, '', widget.college,widget.floor,list,0))),
    );
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
  void _showDialog(var error, Rooms item,int pos) {
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
                _deleteRooms(context, item, pos);
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

  _navigateToStudent(BuildContext context, String roomNumber, String floorLevel,int maxRoomCapacity) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentList(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college,roomNumber:roomNumber,floor: floorLevel,roomCapacity:maxRoomCapacity)));


  }


}

