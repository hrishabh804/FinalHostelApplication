
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ComplainPage extends StatefulWidget {
  String uid;
  String studentEmail;
  String name;
  String college;
  ComplainPage(this.uid,this.studentEmail,this.name,this.college);
  @override
  _ComplainPageState createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  List<MyComplain> allData = [];
  StreamSubscription<QuerySnapshot>complaintSub;
  @override
  // ignore: must_call_super
  void initState() {
    CollectionReference ref = Firestore.instance.collection('Complaint');
    complaintSub?.cancel();
    complaintSub=ref.where('uid',isEqualTo: widget.uid).snapshots().listen((QuerySnapshot snapshot) {
        final List<MyComplain> complaint = snapshot.documents
            .map((documentSnapshot) => MyComplain.fromMap(documentSnapshot.data))
            .toList();



      setState(() {
        this.allData=complaint;
        print('Length : ${allData.length}');
      });
    });
  }
  @override
  void dispose() {
    complaintSub?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
     return new Scaffold(
      body: new Container(
        
          child: allData.length == 0
              ? new Center(child:Text(' No Data Available',))
              : new ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (_, index) {
                    return uI(
                      allData[index]._email,
                      allData[index]._date,
                      allData[index].complainType,
                      allData[index].message,
                    );
                  },
                )),);
  }

  Widget uI(String email,String date,String complainType, String message) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('By : $email',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            new Text('ComplainType : $complainType',style: Theme.of(context).textTheme.title,),
            SizedBox(height: 10,),
            new Text('message : $message'),
            SizedBox(height: 10,),
            new Text('date: $date'),
          ],
        ),
      ),
    );
  }
}

class MyComplain{
  String  _complainType,_message,_email,_date;
  String get complainType => _complainType;
  String get message => _message;
  String get email => _email;
  String get date => _date;

  MyComplain(this._complainType,this._message,this._email,this._date);
  MyComplain.fromMap(Map<String,dynamic> map){

    this._complainType = map['complainType'];
    this._message = map['message'];
    this._email = map['email'];
    this._date = map['date'];
  }
}