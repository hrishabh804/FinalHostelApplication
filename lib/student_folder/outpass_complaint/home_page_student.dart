import 'package:flutter/material.dart';
import 'package:hostel_project/student_folder/outpass_complaint/options_list.dart';
import "./pages/outpass_page.dart";
import "./pages/leave_page.dart";
import './pages/complaint_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget{
  String uid;
  String studentEmail;
  String name;
  String college;
  HomePage(this.uid,this.studentEmail,this.name,this.college);

  @override
  State<StatefulWidget> createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  bool isOpened = false;
  TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Student Portal'),
        bottom: new TabBar(controller: tabController,tabs: <Widget>[
          new Tab(
            icon: new Icon(Icons.playlist_add),
            text: "Outpass",
          ),
          new Tab(
            icon: new Icon(Icons.arrow_forward,),
            text: "Leave",
          ),
          new Tab(
            icon: new Icon(Icons.announcement,),
            text: "Complaints",
          )
        ],
        ),

      ),
      body:new Stack( children: <Widget>[new TabBarView(children: <Widget>[
        new OutpassPage(widget.uid,widget.studentEmail,widget.name,widget.college),new LeavePage(widget.uid,widget.studentEmail,widget.name,widget.college),new ComplainPage(widget.uid,widget.studentEmail,widget.name,widget.college)
      ],
        controller: tabController,
      ),
      ],
      ),
      // bottomNavigationBar: BottomAppBar(child: new Container(height: 60.0,color: Colors.blue,),notchMargin: 2.0,shape: CircularNotchedRectangle(),),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ProductFAB(widget.uid,widget.studentEmail,widget.name,widget.college),
    );
  }

}

