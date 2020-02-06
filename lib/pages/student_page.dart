import 'package:flutter/material.dart';
import 'package:hostel_project/bloc_navigation/navigaition_bloc.dart';

class StudentPage extends StatefulWidget with NavigationStates{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudentPageState();
  }

}

class StudentPageState extends State<StudentPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        child: Text("HOMEPAGE",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
      ),
    );
  }
}