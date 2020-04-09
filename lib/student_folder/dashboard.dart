import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/model/Student.dart';
import 'package:hostel_project/services/student_firestore_firebase.dart';
import 'package:hostel_project/student_folder/profileCard.dart';
import 'package:hostel_project/ui/items.dart';
// ignore: must_be_immutable
class Dashboard extends StatefulWidget{
  Dashboard(this.uid,this.studentEmail,this.college);
  String uid;
  String studentEmail;
  String college;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DashboardState();
  }

}

class _DashboardState extends State<Dashboard> {
  StudentFirestoreService db = new StudentFirestoreService();
  StreamSubscription<QuerySnapshot>studentSub;
  List<Students> items ;



  @override
  void initState() {
    super.initState();

    items = new List();

    studentSub?.cancel();
    print(widget.college);
    studentSub = db.getLoggedStudent(widget.studentEmail).listen((QuerySnapshot snapshot) {
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
    studentSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body:  ListView.builder(
          itemCount: items.length,
        itemBuilder: (context, position) {
            return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              height: 250,
              width: 800,
              child: ProfileCard(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.lightBlueAccent, Colors.greenAccent],
                    stops: [0.3, 0.95],
                  ),
                  borderRadius: BorderRadius.circular(25)
                ),
                image: '${items[0].imageURL}',
                name: '${items[0].name}',
                number: '${items[0].usn}',
                company: Center(
                  child: Text(
                    'HOSTEL ID',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          Row(
            children: <Widget>[
              Container(padding:EdgeInsets.all(10),child: FlipCard(direction:FlipDirection.HORIZONTAL,front: Item(icon: Icons.home,title:'Room Number',color:0xffff5252,),back:Item(icon: Icons.home,title:'${items[0].roomNumber}',color:0xffff5252,),)),
              SizedBox(width: 10,),
              FlipCard(direction:FlipDirection.VERTICAL,front: Item(icon: Icons.assignment,title:'BRANCH',color:0xffffe57f,),back: Item(icon: Icons.assignment,title:'${items[0].branch.toUpperCase()}',color:0xffffe57f,),),
            ],
          ),
            Row(
              children: <Widget>[
                Container(padding:EdgeInsets.all(10),child: FlipCard(direction:FlipDirection.HORIZONTAL,front: Item(icon: Icons.hotel,title:'Floor',color:0xff607d8b,),back:Item(icon: Icons.hotel,title:'${items[0].floor}',color:0xff607d8b ))),
                SizedBox(width: 10,),
                FlipCard(direction:FlipDirection.VERTICAL,front: Item(icon: Icons.business,title:'College',color:0xff1de9b6,),back: Item(icon: Icons.business,title:'${items[0].collegeName}',color:0xff1de9b6,),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(50)),height:150,width:200,padding:EdgeInsets.all(10),child: Card(color: Color(0xffb2ff59),child: Container(alignment:Alignment.bottomLeft,child: Column(
                  children: <Widget>[
                    Center(child: Text('Hostel fees Paid',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),),
                    Row(
                      children: <Widget>[
                        Icon(Icons.trending_up,size: 30,),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(30),
                          child: Text('+23000',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.green),),
                        )
                      ],
                    ),
                  ],
                ),),)),
                SizedBox(width: 10,),
                Container(height:150,width:200,padding:EdgeInsets.all(10),child: Card(color: Color(0xff81d4fa),child: Container(alignment:Alignment.bottomLeft,child: Column(
                  children: <Widget>[
                    Center(child: Text('Hostel fees Due',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),),
                    Row(
                      children: <Widget>[
                        Icon(Icons.trending_down,size: 30,),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(30),
                          child: Text('-'+'${items[0].dueHostelFees}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.red),),
                        )
                      ],
                    ),
                  ],
                ),),)),
              ],
            ),
            SizedBox(height: 20,)
          ]);},
        )));
  }
}