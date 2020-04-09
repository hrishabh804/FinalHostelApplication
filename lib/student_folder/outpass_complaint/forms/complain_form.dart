import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/student_folder/outpass_complaint/home_page_student.dart';

// ignore: must_be_immutable
class ComplainForm extends StatefulWidget {
  ComplainForm(this.uid,this.studentEmail,this.name,this.college);
  String uid;
  String studentEmail;
  String name;
  String college;
  @override
  _ComplainFormState createState() => _ComplainFormState();
}

class _ComplainFormState extends State<ComplainForm> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;
  String complainType,message;
  List<DropdownMenuItem<String>> items = [
    new DropdownMenuItem(
      child: new Text('Electricity'),
      value: 'Electricity',
    ),
    new DropdownMenuItem(
      child: new Text('Furniture'),
      value: 'Furniture',
    ),
    new DropdownMenuItem(
      child: new Text('Network'),
      value: 'Network',
    ),
    new DropdownMenuItem(
      child: new Text('Water'),
      value: 'Water',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Complain Form'),
      ),
      body: new SingleChildScrollView(
          child: new Container(
            padding: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              autovalidate: _autovalidate,
              child: FormUI(),
            ),
          ),
        ),

    );
  }
  // ignore: non_constant_identifier_names
  Widget FormUI() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new DropdownButtonHideUnderline(
                child: new DropdownButton(
              items: items,
              hint: new Text('Select thpe of complain.'),
              value: complainType,
              onChanged: (String val) {
                setState(() {
                  complainType = val;
                });
              },
            ))
          ],
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Message'),
          onSaved: (val) {
            message = val;
          },
          validator: validateMessage,
          maxLines: 5,
          maxLength: 256,
        ),
        new RaisedButton(
          onPressed: _sendToServer,
          child: new Text('Send'),
        ),
      ],
    );
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      CollectionReference ref = Firestore.instance.collection('Complaint');
      var dataComplain = {
        "complainType": complainType,
        "uid":widget.uid,
        "email":widget.studentEmail,
        'date': DateTime.now().toIso8601String().toString(),
        "message": message,
      };
      ref.add(dataComplain).then((v) {
        _key.currentState.reset();
      });
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HomePage(widget.uid,widget.studentEmail,widget.name,widget.college)));
  }
  String validateMessage(String val) {
    return val.length == 0 ? "Write Something" : null;
  }
}