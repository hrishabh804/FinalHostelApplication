import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileCard extends StatelessWidget {
  final BoxDecoration decoration;
  final String image;
  final String number;
  final String name;
  final Widget company;

  const ProfileCard({
    this.decoration,
    this.image,
    this.number,
    this.name,
    this.company,
  });

  @override
  Widget build(BuildContext context) {
    String url = image;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 300,
      height: 300,
      decoration: decoration,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: company,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      number,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              image!=null?
              Image.network(
                url,
                height: 130 ,
              ):
                  Container(
                    height: 80,
                    child: Icon(Icons.account_circle),
                  )

            ],
          )
        ],
      ),
    );
  }
}