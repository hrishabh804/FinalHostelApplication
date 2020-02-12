import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemDashboard extends StatelessWidget {
  final String title;
  final dynamic icon;
  final dynamic color;
  String college;

  int length=0;

  ItemDashboard({this.title, this.icon, this.color,this.college});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: (screenWidth - 40 - 17) / 2,
      height: (screenWidth - 40 - 17 - 30) / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(color),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Container(
            child: Icon(icon, size: 40, color: Colors.white),
            margin: EdgeInsets.only(bottom: 10),
          ),
        ),
          StreamBuilder(
            stream: Firestore.instance.collection(title).where('collegeName',isEqualTo: college).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print('hellp there');
                print('college');
              }
              else {
                if (snapshot.data.documents.length != 0)
                  length = snapshot.data.documents.length;
                if (snapshot.data.documents.length == 0) {
                  length = 0;
                }

              }

                return Text('$title'+' Count: '+'${length.toString()}',
                    style: TextStyle(
                        fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold));
            }
          ),
      ]),
    );
  }
  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}