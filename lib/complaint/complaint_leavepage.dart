import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



// ignore: must_be_immutable
class ComplaintLeavePage extends StatefulWidget {
  String uid;
  String studentEmail;
  String name;
  String college;
  ComplaintLeavePage(this.uid,this.studentEmail,this.name,this.college);
  @override
  _ComplaintLeavePageState createState() => _ComplaintLeavePageState();
}

class _ComplaintLeavePageState extends State<ComplaintLeavePage> {
  StreamSubscription<QuerySnapshot>leaveSub;
  List<MyLeave> allData = [];

  @override
  // ignore: must_call_super
  void initState() {
    CollectionReference ref = Firestore.instance.collection('Leave');
    leaveSub?.cancel();
    leaveSub = ref.snapshots().listen((QuerySnapshot snapshot) {
      final List<MyLeave> leaves = snapshot.documents
          .map((documentSnapshot) => MyLeave.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.allData=leaves;
        print('Length : ${allData.length}');
      });
    });
  }
  @override
  void dispose() {
    leaveSub?.cancel();
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
              return UI(
                allData[index].name,
                allData[index].dateOfDeparture,
                allData[index].dateOfArrival,
                allData[index].departureTime,
                allData[index].inTime,
                allData[index].address,
                allData[index].reason,
                allData[index].status,
                allData[index].email
              );
            },
          )),);
  }

  // ignore: non_constant_identifier_names
  Widget UI(String name, String dateOfDeparture, String dateOfArrival,String departureTime, String inTime,String address,String reason,String status,String email) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Name : $name',style: Theme.of(context).textTheme.title,),
            new Text('DateOfDeparture : $dateOfDeparture'),
            new Text('DateOfArrival : $dateOfArrival'),
            new Text('DepartureTime : $departureTime'),
            new Text('inTime : $inTime'),
            new Text('address : $address'),
            new Text('reason : $reason'),
            status=="Accepted......."?new Text('Status: $status',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w900),):new Text('Status: $status',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900),),
            SizedBox(height: 10,),
            Center(child:RaisedButton(child: Text("ACCEPT"),onPressed: ()=>_updateData(email),))
          ],
        ),
      ),
    );
  }

  _updateData(String email) async {
    print(email);
    await Firestore.instance.collection('Leave').where('email',isEqualTo: email).getDocuments().then((value){
      String str;
      value.documents.forEach((f)=> {
        str = f.documentID,
        Firestore.instance.collection('Leave').document(f.documentID).updateData({"status":"Accepted......."})
      });
    });
  }

}

class MyLeave{
  String _name;
  String _dateOfDeparture;
  String _dateOfArrival;
  String _departureTime;
  String _inTime;
  String _address;
  String _reason;
  String _status;
  String _email;
  String get name => _name;
  String get dateOfDeparture => _dateOfDeparture;
  String get dateOfArrival => _dateOfArrival;
  String get departureTime => _departureTime;
  String get inTime => _inTime;
  String get address => _address;
  String get reason => _reason;
  String get status => _status;
  String get email => _email;



  MyLeave(this._name,this._dateOfDeparture,this._dateOfArrival,this._departureTime,this._inTime,this._address,this._reason,this._status,String email);
  MyLeave.fromMap(Map<String,dynamic> map){
    this._name = map['name'];
    this._dateOfDeparture = map['dateOfDeparture'];
    this._dateOfArrival = map['dateOfArrival'];
    this._departureTime = map['departureTime'];
    this._inTime = map['inTime'];
    this._address = map['address'];
    this._reason = map['reason'];
    this._status = map['status'];
    this._email = map['email'];
  }
}