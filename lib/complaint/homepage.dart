import 'package:flutter/material.dart';
import 'package:hostel_project/complaint/complaint_leavepage.dart';
import 'package:hostel_project/complaint/complaint_outpass.dart';
import 'package:hostel_project/complaint/complaint_page.dart';

// ignore: must_be_immutable
class ComplaintHomePage extends StatefulWidget{
  String uid;
  String adminEmail;
  String name;
  String college;
  ComplaintHomePage({this.name,this.adminEmail,this.uid,this.college});

  @override
  State<StatefulWidget> createState() => new _HomePageState();

}

class _HomePageState extends State<ComplaintHomePage> with TickerProviderStateMixin{

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
        new ComplaintOutpassPage(widget.uid, widget.adminEmail, widget.name, widget.college),new ComplaintLeavePage(widget.uid, widget.adminEmail, widget.name, widget.college),new AdminComplainPage(widget.uid, widget.adminEmail, widget.name, widget.college)
      ],
        controller: tabController,
      ),
      ],
      ),
      // bottomNavigationBar: BottomAppBar(child: new Container(height: 60.0,color: Colors.blue,),notchMargin: 2.0,shape: CircularNotchedRectangle(),),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

}

