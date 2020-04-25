import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ComplaintOutpassPage extends StatefulWidget {
  String uid;
  String studentEmail;
  String name;
  String college;
  ComplaintOutpassPage(this.uid,this.studentEmail,this.name,this.college);
  @override
  _ComplaintOutpassPageState createState() => _ComplaintOutpassPageState();
}

class _ComplaintOutpassPageState extends State<ComplaintOutpassPage> {
  StreamSubscription<QuerySnapshot>outSub;
  List<Outpass> allData = [];

  @override
  // ignore: must_call_super
  void initState() {

    CollectionReference ref = Firestore.instance.collection('Outpass');
    outSub?.cancel();
    outSub = ref.snapshots().listen((QuerySnapshot snapshot) {
      final List<Outpass> outpass = snapshot.documents
          .map((documentSnapshot) => Outpass.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.allData=outpass;
        print('Length : ${allData.length}');
      });
    });
  }
  @override
  void dispose() {
    outSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Container(
          child: allData.length == 0
              ? new Center(child:Text(' No Data Available',))
              : new ListView.builder(
            itemCount: allData.length,
            itemBuilder: (_, index) {
              return UI(
                allData[index].name,
                allData[index].outpassDate,
                allData[index].outpassDepartureTime,
                allData[index].outpassInTime,
                allData[index].outpassAddress,
                allData[index].status,
                allData[index].email
              );
            },
          )),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UI(String outpassName, String outpassDate, String outpassDepartureTime,String outpassInTime, String outpassAddress,String status,String email) {

    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('personNameOutpass : $outpassName',style: Theme.of(context).textTheme.title,),
            new Text('DATE : $outpassDate'),
            new Text('DepartureTime : $outpassDepartureTime'),
            new Text('InTime : $outpassInTime'),
            new Text('Address : $outpassAddress'),
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
    await Firestore.instance.collection('Outpass').where('email',isEqualTo: email).getDocuments().then((value){
      String str;
      value.documents.forEach((f)=> {
          str = f.documentID,
        Firestore.instance.collection('Outpass').document(f.documentID).updateData({"status":"Accepted......."})
      });
    });
  }


}

class Outpass {
  String _id,_name,_outpassDate,_outpassDepartureTime,_outpassInTime,_outpassAddress;
  String _status;
  String _email;
  String get name => _name;
  String get outpassDate => _outpassDate;
  String get outpassDepartureTime => _outpassDepartureTime;
  String get outpassInTime => _outpassInTime;
  String get outpassAddress => _outpassAddress;
  String get status => _status;
  String get email => _email;

  Outpass(this._id,this._name,this._outpassDate,this._outpassDepartureTime,this._outpassInTime,this._outpassAddress,this._status,this._email);
  String get id => _id;
  Outpass.fromMap(Map<String,dynamic> map){
    this._name = map['personNameOutpass'];
    this._outpassDate = map['date'];
    this._outpassDepartureTime = map['departureTime'];
    this._outpassInTime = map['inTime'];
    this._outpassAddress = map['address'];
    this._status = map['status'];
    this._email = map['email'];
  }
}