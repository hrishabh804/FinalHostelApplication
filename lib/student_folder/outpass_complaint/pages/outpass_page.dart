import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OutpassPage extends StatefulWidget {
  String uid;
  String studentEmail;
  String name;
  String college;
  OutpassPage(this.uid,this.studentEmail,this.name,this.college);
  @override
  _OutpassPageState createState() => _OutpassPageState();
}

class _OutpassPageState extends State<OutpassPage> {
  StreamSubscription<QuerySnapshot>outSub;
  List<Outpass> allData = [];

  @override
  // ignore: must_call_super
  void initState() {

    CollectionReference ref = Firestore.instance.collection('Outpass');
    outSub?.cancel();
    outSub = ref.where('uid',isEqualTo: widget.uid).snapshots().listen((QuerySnapshot snapshot) {
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
                    );
                  },
                )),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UI(String outpassName, String outpassDate, String outpassDepartureTime,String outpassInTime, String outpassAddress,String status) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('personNameOutpass : $outpassName',style: Theme.of(context).textTheme.title,),
            new Text('date : $outpassDate'),
            new Text('departureTime : $outpassDepartureTime'),
            new Text('inTime : $outpassInTime'),
            new Text('address : $outpassAddress'),
            new Text('Status: $status',style: TextStyle(color: Colors.red),)



          ],
        ),
      ),
    );
  }
}

class Outpass {
  String _id,_name,_outpassDate,_outpassDepartureTime,_outpassInTime,_outpassAddress;
  String _status;
  String get name => _name;
  String get outpassDate => _outpassDate;
  String get outpassDepartureTime => _outpassDepartureTime;
  String get outpassInTime => _outpassInTime;
  String get outpassAddress => _outpassAddress;
  String get status => _status;

  Outpass(this._id,this._name,this._outpassDate,this._outpassDepartureTime,this._outpassInTime,this._outpassAddress,this._status);
  String get id => _id;
  Outpass.fromMap(Map<String,dynamic> map){
    this._name = map['personNameOutpass'];
    this._outpassDate = map['date'];
    this._outpassDepartureTime = map['departureTime'];
    this._outpassInTime = map['inTime'];
    this._outpassAddress = map['address'];
    this._status = map['status'];
  }
}