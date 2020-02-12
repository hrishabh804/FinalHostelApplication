import 'package:flutter/material.dart';
import 'package:hostel_project/pages/all_room_list.dart';
import 'package:hostel_project/pages/all_student_page.dart';
import 'package:hostel_project/ui/items_dashboard.dart';

import 'floor_page.dart';
class HomePage extends StatefulWidget {
  HomePage({this.name,this.adminEmail,this.uid,this.college});
  final String adminEmail;
  final String name;
  final String college;
  final String uid;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Container(
          child: Row(
            children:<Widget>[
              Icon(Icons.dashboard),
              Text('DASHBOARD')
            ]
          ),
        ),),
          body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment(1, 0.0),
                        // 10% of the width, so there are ten blinds.
                        colors: [Colors.greenAccent, const Color(0xFF4EC5AC)]
                    )),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(children: [
                  Expanded(
                      child:
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(
                          width: 190,
                          height: 190,
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.person, size: 90,),
                              Text(widget.name.toUpperCase()+' RAJAWAT')
                            ],
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(100.0),
                              border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 25),
                              color: Colors.transparent),
                        ),

                      ]),

                      flex: 1),


                  Wrap(
                    spacing: 17,
                    runSpacing: 17,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => FloorList(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college),
                              transitionsBuilder: (
                                  BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child,
                                  ) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.0, 1.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset.zero,
                                      end: const Offset(0.0, 1.0),
                                    ).animate(secondaryAnimation),
                                    child: child,
                                  ),
                                );
                              },
                              transitionDuration: const Duration(milliseconds: 3000)));
                        },

                        child: ItemDashboard(
                          title: 'Floors', icon: Icons.home, color: 0xffFED525,
                            college: widget.college),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => AllRoomList(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college),
                                transitionsBuilder: (
                                    BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                    Widget child,
                                    ) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(1.5, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: Offset.zero,
                                        end: const Offset(1.5, 0.0),
                                      ).animate(secondaryAnimation),
                                      child: child,
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 3000)));
                          },
                        child: ItemDashboard(title: 'Rooms',
                            icon: Icons.star,
                            color: 0xffFD637B,
                            college: widget.college),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => AllStudentList(name:widget.name,adminEmail:widget.adminEmail,uid:widget.uid,college:widget.college),
                              transitionsBuilder: (
                                  BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child,
                                  ) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.5, 1.5),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset.zero,
                                      end: const Offset(1.5, 1.5),
                                    ).animate(secondaryAnimation),
                                    child: child,
                                  ),
                                );
                              },
                              transitionDuration: const Duration(milliseconds: 3000)));
                        },
                        child: ItemDashboard(
                            title: 'Students',
                            icon: Icons.account_circle,
                            color: 0xff21CDFF,
                        college: widget.college,),
                      ),
                      InkWell(
                        onTap: ()=> print('abc'),
                        child: ItemDashboard(title: 'Floors',
                            icon: Icons.report_problem,
                            color: 0xff7585F6,
                            college: widget.college),
                      )
                    ],
                  ),
                ])),
          ),
    );
  }
}


