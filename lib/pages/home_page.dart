import 'package:flutter/material.dart';
import 'package:hostel_project/bloc_navigation/navigaition_bloc.dart';

class HomePage extends StatefulWidget with NavigationStates {
  HomePage({this.name});
   final String name;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.name );
    print("value");
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("WELCOME TO HOME PAGE")),
      body: Center(
        child: Container(
          child: Text("Home Page",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
        ),
      ),
    );
  }
}