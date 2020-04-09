import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/services/authentication.dart';
import 'package:hostel_project/student_folder/role_as_student.dart';
import 'package:permission_handler/permission_handler.dart';
import 'admin_page.dart';

// ignore: must_be_immutable
class Verification extends StatefulWidget{
  Verification({this.userId});
  String userId;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VerificationState();
  }

}

class _VerificationState extends State<Verification> {
  Map<PermissionGroup, PermissionStatus> permissions;
  String _userEmail;
  String getEmail() {
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _userEmail = user.email;
      });
    });
    return _userEmail;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _userEmail = user.email;
      });
    });
  }
  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.location,
      PermissionGroup.camera,
      PermissionGroup.locationAlways,
      PermissionGroup.phone,
      PermissionGroup.sensors,
      PermissionGroup.storage,
      PermissionGroup.microphone,
    ]);
  }

//Small issue here while loading it takes null value first then start our code
  //will work in this when our app will have major issue due to this
  @override
  Widget build(BuildContext context) {
    print(_userEmail);
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance.collection('UserRoles').where('email',isEqualTo:_userEmail).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('PLEASE WAIT WE ARE VERIFYING AUR AUTHENTICITY',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),),);
            }
            if(snapshot.hasError){
              _roleValidation();
            }
            var doc;
            if(snapshot.data.documents.length!=0)
              doc = snapshot.data.documents[0];

            if( snapshot.data.documents.length!=0 && doc['role']=='warden'){
              print("sucess");
              print(doc['name']);
              print(snapshot.data.documents.length);
              return AdminPage(uid:widget.userId,name:doc['name'],adminEmail:_userEmail,college:doc['college']);
            }
            if(snapshot.data.documents.length!=0 && doc['role']=='student') {
              print("student");
              print("sucess");
              print(doc['name']);
              print(snapshot.data.documents.length);
              return RoleStudent(uid:widget.userId,name:doc['name'],studentEmail:_userEmail,college:doc['college']);
            }
            return _roleValidation();
          },),
    );

  }
   _roleValidation() {
    Auth auth = new Auth();
    return Scaffold(
      appBar: AppBar(title:Text('NO ENTRY FOUND')),
      body: AlertDialog(
        title: Text('NO ENRTY POINT'),
        content: Text('PLEASE CONTACT YOUR WARDEN FOR FUTHER INFORMATION'),
        actions: <Widget>[
          RaisedButton(
            child: Text('EXIT',
            style: TextStyle(color: Colors.black),),
            onPressed:()=>
            {
              auth.signOut(),
              Navigator.of(context).pushReplacementNamed('/Auth')
            },
          )],
      ),
    );



    }

  }