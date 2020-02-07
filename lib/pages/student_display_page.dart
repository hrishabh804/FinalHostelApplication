import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/model/Student.dart';
import 'package:hostel_project/services/student_firestore_firebase.dart';
import 'package:hostel_project/services/user_roles_firestore.dart';
import 'package:hostel_project/ui/create_new_student.dart';
import 'package:slimy_card/slimy_card.dart';

// ignore: must_be_immutable
class StudentList extends StatefulWidget {
  StudentList({this.uid,this.name,this.adminEmail,this.college, this.floor,this.roomNumber});
  String uid;
  String name;
  String adminEmail;
  String college;
  String floor;
  String roomNumber;
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return _StudentListState();
  }

}
class _StudentListState extends State<StudentList> {
  List<Students> items;
  StudentFirestoreService db = new StudentFirestoreService();
  RoleFirestoreService db1 = new RoleFirestoreService();
  StreamSubscription<QuerySnapshot>roomsSub;
  Random random = new Random();



  @override
   initState() {

    super.initState();
    items = new List();
    roomsSub?.cancel();
    roomsSub = db.getStudentList(widget.roomNumber,widget.floor,widget.college).listen((QuerySnapshot snapshot) {
      final List<Students> rooms = snapshot.documents
          .map((documentSnapshot) => Students.fromMap(documentSnapshot.data))
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
        title: Text('ROOM NUMBER:'+" "+widget.roomNumber),
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
                  child:Container(
                    child:SlimyCard(
                      color: Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255)),
                      width:600,
                      topCardHeight: 300,
                      bottomCardHeight: 400,
                      borderRadius: 30,
                      topCardWidget: myWidget1(items[position]),
                      bottomCardWidget: Text('${widget.uid}'),
                      slimeEnabled: true,
                    ),
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
        onPressed: () =>
        {
          _createNewStudent1(context),
        }),
    );
  }


  // ignore: unused_element
  void _navigateToStudent(BuildContext context, Students students) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateStudentPage(students,uid:widget.uid)),
    );
  }
  void _createNewStudent1(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateStudentPage(Students(null,'','',widget.roomNumber, widget.college,widget.floor,'',''),uid:widget.uid)),
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
  void _showDialog(var error, Students item,int pos) {
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
                _deleteStudent(context, item, pos);
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

  myWidget1(Students item) {
   return Container(
       padding: const EdgeInsets.only(top: 5.0),
       child: Column(
         children: <Widget>[
       item.imageURL != null
       ? Image.network(
         item.imageURL,
         width: 300,
         height: 200,
       )
           : Container(
       height: 80,
     width: 50,
   ),

          Text('NAME:'+' '+item.name,
             style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
           Text('USN:'+' '+item.usn,
           style: TextStyle(fontSize: 19,fontWeight: FontWeight.w900),),

         ]

   ));



  }


  myWidget2() {
    return Text('HELLO WORLD');
  }

  Future _deleteStudent(BuildContext context, Students students, int position) async {
    String usn = students.usn.toUpperCase();
    String college = students.collegeName.toUpperCase();
    String url = students.imageURL;
    print(url);
    db.deleteStudents(students.id).then((student)async {
      db.deleteStudentFromRoom(students.floor, students.collegeName,students.roomNumber,students.name);
      db1.deleteFromUserRole(students.email);
      setState(() {
        StorageReference storageReference = FirebaseStorage.instance.ref().child('Students/$college/$usn');
        storageReference.delete().then((onValue){
          print('Deleted');
          items.removeAt(position);
        }).catchError((onError){
          print(onError);
        });


      });
    });
  }

}
