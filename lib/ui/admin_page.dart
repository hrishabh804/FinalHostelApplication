import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_project/bloc_navigation/navigaition_bloc.dart';
import 'package:hostel_project/ui/sidebar.dart';

// ignore: must_be_immutable
class AdminPage extends StatefulWidget{
  AdminPage({this.uid,this.name,this.adminEmail,this.college});
  String adminEmail;
  String name;
  String uid;
  String college;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AdminPageState();
  }

}

class _AdminPageState extends State<AdminPage>{
  @override
  Widget build(BuildContext context) {
    print(widget.name);
    print(widget.adminEmail);
    print(widget.uid);
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college),
          ],
        ),
      ),
    );
  }
}