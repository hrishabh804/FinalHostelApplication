import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_project/bloc_navigation/navigaition_bloc.dart';
import 'package:hostel_project/complaint/homepage.dart';
import 'package:hostel_project/pages/all_student_page.dart';
import 'package:hostel_project/pages/floor_page.dart';
import 'package:hostel_project/pages/home_page.dart';
import 'package:hostel_project/services/authentication.dart';
import 'package:hostel_project/widget/menu_items.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class SideBar extends StatefulWidget {
  SideBar({this.uid,this.name,this.adminEmail,this.college});
  String uid;
  String name;
  String adminEmail;
  String college;
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  Auth _auth = new Auth();
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFF262AAA),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          widget.name,
                          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          widget.adminEmail,
                          style: TextStyle(
                            color: Color(0xFF1BB5FD),
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.dashboard,
                        title: "Dashboard",
                        onTap: () {
                          onIconPressed();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college)));
                        },
                      ),
                      MenuItem(
                        icon: Icons.hotel,
                        title: "Floors",
                        onTap: () {
                          onIconPressed();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FloorList(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college)));
                        },
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Home Page",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.StudentPageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.account_circle,
                        title: "Student",
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AllStudentList(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college)))
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.warning,
                        title: "Complains",
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplaintHomePage(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college)))
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Logout",
                        onTap: (){
                          _auth.signOut();
                          Navigator.of(context).pushReplacementNamed('/Auth');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}