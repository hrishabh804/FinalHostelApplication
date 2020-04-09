import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_project/student_folder/outpass_complaint/home_page_student.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


// ignore: must_be_immutable
class LeaveForm extends StatefulWidget {
  String uid;
  String studentEmail;
  String name;
  String college;
  LeaveForm(this.uid,this.studentEmail,this.name,this.college);
  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  
  
  GlobalKey<FormState> _key = new GlobalKey();
  TextEditingController _nameController = new TextEditingController();
  bool _autoValidate = false;
  String name;
  String dateOfDeparture;
  String dateOfArrival;
  String departureTime;
  String inTime;
  String address;
  String reason;
  String _date = "Not set";
  String _date1="Not set";
  String _time = "Not set";
  String _time1 = "Not set";
  void initState() {
    super.initState();

    _nameController = new TextEditingController(text: widget.name);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              autovalidate: _autoValidate,
              child: formUI(),
            ),
        ),
      ),
    );
  }



  Widget formUI() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your first and last name',
                  labelText: 'Name',

                ),
          controller:_nameController,
          enabled: false,
              ),
        SizedBox(height: 20,),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          elevation: 4.0,
          onPressed: () {
            DatePicker.showDatePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                minTime: DateTime(2000, 1, 1),
                maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                  print('confirm $date');
                  _date = '${date.year} - ${date.month} - ${date.day}';
                  this.dateOfDeparture = '${date.year} - ${date.month} - ${date.day}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            size: 18.0,
                            color: Colors.teal,
                          ),
                          Text(
                            " $_date",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "Departure Date",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ],
            ),
          ),
          color: Colors.white,
        ),
        SizedBox(height: 20,),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          elevation: 4.0,
          onPressed: () {
            DatePicker.showDatePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                minTime: DateTime(2000, 1, 1),
                maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                  print('confirm $date');
                  _date1 = '${date.year} - ${date.month} - ${date.day}';
                  this.dateOfArrival= '${date.year} - ${date.month} - ${date.day}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            size: 18.0,
                            color: Colors.teal,
                          ),
                          Text(
                            " $_date1",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "Arrival Date",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ],
            ),
          ),
          color: Colors.white,
        ),
        SizedBox(height: 20,),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          elevation: 4.0,
          onPressed: () {
            DatePicker.showTimePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true, onConfirm: (time) {
                  print('confirm $time');
                  _time = '${time.hour} : ${time.minute} : ${time.second}';
                  this.departureTime= '${time.hour} : ${time.minute} : ${time.second}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 18.0,
                            color: Colors.teal,
                          ),
                          Text(
                            " $_time",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "Departure Time",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ],
            ),
          ),
          color: Colors.white,
        ),
        SizedBox(height: 20,),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          elevation: 4.0,
          onPressed: () {
            DatePicker.showTimePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true, onConfirm: (time) {
                  print('confirm $time');
                  _time1 = '${time.hour} : ${time.minute} : ${time.second}';
                  this.inTime = '${time.hour} : ${time.minute} : ${time.second}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 18.0,
                            color: Colors.teal,
                          ),
                          Text(
                            " $_time1",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "Arrival Time",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ],
            ),
          ),
          color: Colors.white,
        ),
              SizedBox(height: 20,),
              TextField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.add_location),
                  hintText: 'Enter the address of visit',
                  labelText: 'Address',
                ),
                keyboardType: TextInputType.text,
                onChanged: (value){
                  this.address = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.assistant),
                  hintText: 'Enter the Reason of leave',
                  labelText: 'Reason',
                ),
                keyboardType: TextInputType.text,
                onChanged: (value){
                  this.reason = value;
                },
              ),
                    SizedBox(height: 20,),
                    Center(
                      child: new RaisedButton(
          onPressed: _sendToServer,
          child: new Text('Send'),
        ),
                    ),

      ],
    );
  }


  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      CollectionReference ref = Firestore.instance.collection('Leave');
      var dataLeave = {
        'uid':widget.uid,
        'email':widget.studentEmail,
        'college':widget.college,
        'name': widget.name,
                    'dateOfDeparture': this.dateOfDeparture,
                    'dateOfArrival': this.dateOfArrival,
                    'departureTime':this.departureTime,
                    'inTime': this.inTime,
                    'address': this.address,
                    'reason' : this.reason,
                    'status': 'PENDING.....'
      };
      ref.add(dataLeave).then((v) {
        _key.currentState.reset();
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }

     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HomePage(widget.uid,widget.studentEmail,widget.name,widget.college)));
  }

}