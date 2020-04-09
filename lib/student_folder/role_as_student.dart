import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/student_folder/chat_page.dart';
import 'package:hostel_project/student_folder/dashboard.dart';
import 'package:hostel_project/student_folder/logout.dart';

import 'outpass_complaint/home_page_student.dart';
// ignore: must_be_immutable
class RoleStudent extends StatefulWidget{
  String uid;
  String name;
  String studentEmail;
  String college;
  RoleStudent({this.uid,this.name,this.studentEmail,this.college});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement

    return _RoleStudentState();
  }

}

class _RoleStudentState extends State<RoleStudent> {
  int _page=0;
  @override
  Widget build(BuildContext context) {
    final _pageOption =[
      Dashboard(widget.uid,widget.studentEmail,widget.name),
      HomePage(widget.uid,widget.studentEmail,widget.name,widget.college),
      Chat(widget.uid,widget.studentEmail,widget.name,widget.college),
      Logout()

    ];
    // TODO: implement build
    return Scaffold(



      bottomNavigationBar: CurvedNavigationBar(
      items: <Widget>[
        Icon(Icons.add, size: 30),
        Icon(Icons.list, size: 30),
        Icon(Icons.message, size: 30),
        Icon(Icons.compare_arrows, size: 30),
      ],
      onTap: (index) {
        setState(() {
          _page=index;
        });

      }

    ),
      body: _pageOption[_page],
    );

  }
}