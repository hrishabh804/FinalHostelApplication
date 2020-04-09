import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/bloc_navigation/navigaition_bloc.dart';


class StudentPage extends StatefulWidget with NavigationStates{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudentPageState();
  }

}
class ColorChoice {
  const ColorChoice({@required this.primary, @required this.gradient});

  final Color primary;
  final List<Color> gradient;
}

class ColorChoices {
  static const List<ColorChoice> choices = [
    ColorChoice(primary: Color(0xFFF77B67), gradient: [const Color.fromRGBO(245, 68, 113, 1.0), const Color.fromRGBO(245, 161, 81, 1.0)]),
    ColorChoice(primary: Color(0xFF5A89E6), gradient: [const Color.fromRGBO(77, 85, 225, 1.0), const Color.fromRGBO(93, 167, 231, 1.0)]),
    ColorChoice(primary: Color(0xFF4EC5AC), gradient: [const Color.fromRGBO(61, 188, 156, 1.0), const Color.fromRGBO(61, 212, 132, 1.0)],

    )
  ];
}
List<TodoObject> list = [
  TodoObject.import( "Dashboard", ColorChoices.choices[1], Icons.dashboard,'Gives statical view of app'),
  TodoObject("Floors", Icons.hotel,'Create edit Floors'),
  TodoObject("Rooms", Icons.star,'Create edit Rooms'),
  TodoObject("Students", Icons.account_circle,'List of all students in hostel'),
  TodoObject("Complains", Icons.warning,'Problems faced by students'),
];



class StudentPageState extends State<StudentPage> {
    ScrollController scrollController;
    Color backgroundColor;
    LinearGradient backgroundGradient;
    Tween<Color> colorTween;
    int currentPage = 0;
    Color constBackColor;

    @override
    // ignore: must_call_super
    void initState() {
      colorTween = ColorTween(begin: list[0].color, end: list[0].color);
      backgroundColor = list[0].color;
      backgroundGradient = list[0].gradient;
      scrollController = ScrollController();
      scrollController.addListener(() {
        ScrollPosition position = scrollController.position;
        int page = position.pixels ~/
            (position.maxScrollExtent / (list.length.toDouble() - 1));
        double pageDo = (position.pixels /
            (position.maxScrollExtent / (list.length.toDouble() - 1)));
        double percent = pageDo - page;
        if (list.length - 1 < page + 1) {
          return;
        }
        colorTween.begin = list[page].color;
        colorTween.end = list[page + 1].color;
        setState(() {
          backgroundGradient =
              list[page].gradient.lerpTo(list[page + 1].gradient, percent);
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      final double _width = MediaQuery
          .of(context)
          .size
          .width;
      return Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(""),),
            body: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 50.0, right: 60.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.black38,
                                          offset: Offset(5.0, 5.0),
                                          blurRadius: 15.0)
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "Hello, Admin.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30.0),
                                ),
                              ),
                              Text(
                                "Given below are options.",
                                style: TextStyle(color: Colors.white70),
                              ),
                              Text(
                                "Explore them using sidebar given on right side.",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 350.0,
                          width: _width,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              TodoObject todoObject = list[index];
                              EdgeInsets padding = const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 20.0,
                                  bottom: 30.0);
                              return Padding(
                                  padding: padding,
                                  child: Container(
                                    child: FlipCard(
                                      front: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(20.0),
                                              boxShadow: [
                                                BoxShadow(color: Colors.black
                                                    .withAlpha(70),
                                                    offset: const Offset(
                                                        3.0, 10.0),
                                                    blurRadius: 15.0)
                                              ]),
                                          height: 250.0,
                                          child: Stack(
                                            children: <Widget>[

                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(50.0),
                                                  ),
                                                ),

                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    16.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Center(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border
                                                                  .all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withAlpha(
                                                                      70),
                                                                  style: BorderStyle
                                                                      .solid,
                                                                  width: 50.0),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(10.0),
                                                              child: Icon(
                                                                todoObject.icon,
                                                                color: todoObject
                                                                    .color,
                                                                size: 50,),
                                                            ),
                                                          ),



                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .center,
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: Text(
                                                              todoObject.title,
                                                              style: TextStyle(
                                                                  fontSize: 30.0),
                                                              softWrap: false,
                                                            ),
                                                          ),

                                                      ),
                                                    ),

                                                    Material(
                                                        type: MaterialType
                                                            .transparency,
                                                        child: FadeTransition(
                                                          opacity: AlwaysStoppedAnimation(
                                                              0.0),
                                                          child: ScaleTransition(
                                                            scale: AlwaysStoppedAnimation(
                                                                0.0),
                                                            child: Container(),
                                                          ),
                                                        ),
                                                      ),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                      back:  Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(20.0),
                                              boxShadow: [
                                                BoxShadow(color: Colors.black
                                                    .withAlpha(70),
                                                    offset: const Offset(
                                                        3.0, 10.0),
                                                    blurRadius: 15.0)
                                              ]),
                                          height: 250.0,
                                          child: Stack(
                                            children: <Widget>[

                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(50.0),
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    16.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Center(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            border: Border
                                                                .all(
                                                                color: Colors
                                                                    .grey
                                                                    .withAlpha(
                                                                    70),
                                                                style: BorderStyle
                                                                    .solid,
                                                                width: 50.0),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .all(10.0),
                                                            child: Icon(
                                                              todoObject.icon,
                                                              color: todoObject
                                                                  .color,
                                                              size: 50,),
                                                          ),
                                                        ),



                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .center,
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: Text(
                                                            todoObject.desc,
                                                            style: TextStyle(
                                                                fontSize: 20.0),
                                                            softWrap: false,
                                                          ),
                                                        ),

                                                      ),
                                                    ),

                                                    Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: FadeTransition(
                                                        opacity: AlwaysStoppedAnimation(
                                                            0.0),
                                                        child: ScaleTransition(
                                                          scale: AlwaysStoppedAnimation(
                                                              0.0),
                                                          child: Container(),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ));
                            },
                            padding: const EdgeInsets.only(left: 40.0,
                                right: 40.0),
                            scrollDirection: Axis.horizontal,
                            physics: CustomScrollPhysics(),
                            controller: scrollController,
                            itemExtent: _width - 80,
                            itemCount: list.length,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    }
  }
class CustomScrollPhysics extends ScrollPhysics {
  CustomScrollPhysics({
    ScrollPhysics parent,
  }) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }


}
class TodoObject {
  TodoObject(String title, IconData icon,String desc) {
    this.title = title;
    this.icon = icon;
    this.desc=desc;
    ColorChoice choice = ColorChoices.choices[new Random().nextInt(ColorChoices.choices.length)];
    this.color = choice.primary;
    this.gradient = LinearGradient(colors: choice.gradient, begin: Alignment.bottomCenter, end: Alignment.topCenter);
  }

  TodoObject.import( String title,ColorChoice color, IconData icon,String desc) {
    this.title = title;
    this.color = color.primary;
    this.desc = desc;
    this.gradient = LinearGradient(colors: color.gradient, begin: Alignment.bottomCenter, end: Alignment.topCenter);
    this.icon = icon;
  }

  String uuid;
  int sortID;
  String title;
  Color color;
  String desc;
  LinearGradient gradient;
  IconData icon;
}



