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
import 'package:hostel_project/ui/updateStudentInfo.dart';
import 'package:slimy_card/slimy_card.dart';

// ignore: must_be_immutable
class AllStudentList extends StatefulWidget {
  AllStudentList({this.uid,this.name,this.adminEmail,this.college, this.floor,this.roomNumber, this.roomCapacity});
  String uid;
  String name;
  String adminEmail;
  String college;
  String floor;
  String roomNumber;
  int roomCapacity;
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return _AllStudentListState();
  }

}
class _AllStudentListState extends State<AllStudentList> {
  List<Students> items;
  StudentFirestoreService db = new StudentFirestoreService();
  RoleFirestoreService db1 = new RoleFirestoreService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription<QuerySnapshot>roomsSub;
  Random random = new Random();



  @override
  initState() {

    super.initState();
    items = new List();
    roomsSub?.cancel();
    roomsSub = db.getAllStudentList(widget.college).listen((QuerySnapshot snapshot) {
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Students'),
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
                      width:500,
                      topCardHeight: 350,
                      bottomCardHeight: 300,
                      borderRadius: 30,
                      topCardWidget: myWidget1(items[position]),
                      bottomCardWidget: myWidget2(items[position]),
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
      MaterialPageRoute(builder: (context) => CreateStudentPage(Students(null,'','',widget.roomNumber, widget.college,widget.floor,'','','','','','','','','',''),uid:widget.uid)),
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
                width: 500,
                height: 240,
              )
                  : Container(
                height: 80,
                width: 50,
              ),

              Container(
                alignment: Alignment.center,
                child: Text('NAME:'+' '+item.name,
                  style: TextStyle(fontSize: 23,fontWeight: FontWeight.w900),),
              ),
              Container(
                alignment: Alignment.center,
                child: Text('USN:'+' '+item.usn,
                  style: TextStyle(fontSize: 23,fontWeight: FontWeight.w900),),
              ),

            ]

        ));



  }


  myWidget2(Students items) {
    return ListView(
        children: <Widget>[
          SizedBox(height:10,),
          Container(alignment:Alignment.topLeft,child: Text('${'ROOM NO:'+' '+items.roomNumber}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),textDirection: TextDirection.ltr,)),
          SizedBox(height: 5,),
          Container(alignment:Alignment.topLeft,child:Text('${'FLOOR:'+' '+items.floor}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),),),
          SizedBox(height: 5,),
          Container(alignment:Alignment.topLeft,child: Text('${'PHONE NO:'+' '+items.phoneNumber}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),)),
          SizedBox(height: 5,),
          Container(alignment:Alignment.topLeft,child:Text('${'EMAIL:'+' '+items.email}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),),),
          SizedBox(height: 5,),
          Container(alignment:Alignment.topLeft,child: Text('${'FATHER NAME:'+' '+items.fatherName}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),)),
          SizedBox(height: 5,),
          Container(alignment:Alignment.topLeft,child: Text('${'FATHER NUMBER:'+' '+items.fatherNumber}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),)),
          SizedBox(height: 5,),
          Container(alignment:Alignment.topLeft,child: Text('${'MOTHER NAME:'+' '+items.motherName}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),)),
          SizedBox(height: 5,),
          Container(alignment:Alignment.topLeft,child: Text('${'MOTHER NUMBER:'+' '+items.motherNumber}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),)),
          SizedBox(height: 5,),
          Container(alignment:Alignment.topLeft,child: Text('${'HOSTEL DUES:'+' '+items.dueHostelFees}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),)),
          SizedBox(height: 10,),

        ]
    );
  }
  void _updateStudentInfo(BuildContext context, Students students) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateStudentInfo(students)),
    );
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

