import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/services/authentication.dart';
import 'authentication/root_page.dart';

void main()=>runApp(new MyApp());
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.lightBlue,
        brightness: Brightness.light
      ),
        darkTheme: ThemeData.dark(),
        home: RootPage(auth:new Auth()),
        routes: <String,WidgetBuilder>{
          '/Auth':(BuildContext context) =>RootPage(auth:new Auth()),
        }
    );
  }

}