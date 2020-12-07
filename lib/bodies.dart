import 'dart:math';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

class CelestialBodies extends StatefulWidget {
  final height;
  final weight;
  CelestialBodies({this.height, this.weight = 0});
  @override
  _CelestialBodiesState createState() => _CelestialBodiesState();
}

class _CelestialBodiesState extends State<CelestialBodies>
    with SingleTickerProviderStateMixin {
  final _bodies = const [
    {
      "name": "MERCURY",
      "pull": 3.70,
      "day": "~1408 Earth Hours",
      "temp": "-184C to 427C",
      "dis": "175.3 M km",
      "missions": "3",
    },
    {
      "name": "VENUS",
      "pull": 8.87,
      "day": "~5832 Earth Hours",
      "temp": "-173C to 426C",
      "dis": "84.4 M km",
      "missions": "25",
    },
    {
      "name": "MOON",
      "pull": 1.62,
      "day": "~656 Earth Hours",
      "temp": "-173C to 127C",
      "dis": "384,400 km",
      "missions": "77",
    },
    {
      "name": "MARS",
      "pull": 3.71,
      "day": "~25 Earth Hours",
      "temp": "-125C to 20C",
      "dis": "205 M km",
      "missions": "28",
    },
    {
      "name": "JUPITER",
      "pull": 24.79,
      "day": "~10 Earth Hours",
      "temp": "-173C to 427C",
      "dis": "768 M km",
      "missions": "6",
    },
    {
      "name": "SATURN",
      "pull": 10.44,
      "day": "~11 Earth Hours",
      "temp": "-185C to -122C",
      "dis": "1.5 B km",
      "missions": "5",
    },
    {
      "name": "URANUS",
      "pull": 8.87,
      "day": "~17 Earth Hours",
      "temp": "-218C to -153C",
      "dis": "3.1 B km",
      "missions": "1",
    },
    {
      "name": "NEPTUNE",
      "pull": 11.15,
      "day": "~16 Earth Hours",
      "temp": "-218C to -200C",
      "dis": "4.6 B km",
      "missions": "1",
    },
    {
      "name": "PLUTO",
      "pull": 0.62,
      "day": "~153 Earth Hours",
      "temp": "-233C to -223C",
      "dis": "5.2 B km",
      "missions": "1",
    },
  ];

  AnimationController _animationController;
  Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  ScrollController _rrectController = ScrollController();
  double weight;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    bool error = false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: widget.height / 2.5,
          width: width / 1.4,
          child: DraggableScrollbar.rrect(
            alwaysVisibleScrollThumb: true,
            heightScrollThumb: widget.height / 5,
            controller: _rrectController,
            backgroundColor: Colors.blue,
            padding: (orientation == Orientation.portrait)
                ? EdgeInsets.only(top: widget.height / 25)
                : EdgeInsets.only(top: 0),
            child: GridView.builder(
              shrinkWrap: true,
              controller: _rrectController,
              itemCount: _bodies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: widget.height / 58,
                  mainAxisSpacing: width / 200,
                  childAspectRatio: 2.4,
                  crossAxisCount:
                      (orientation == Orientation.portrait) ? 1 : 3),
              itemBuilder: (BuildContext ctx, int index) {
                try {
                  if (weight == null) weight = 0;
                  weight = double.parse(widget.weight) /
                      9.8 *
                      _bodies[index]['pull'];
                } catch (e) {
                  error = true;
                }
                return Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.000)
                    ..rotateX(pi * _animation.value),
                  //..rotateY(pi * _animation.value),
                  child: Card(
                    color: Colors.black87,
                    child: _animation.value <= 0.5
                        ? Container(
                            padding: EdgeInsets.only(
                                top: widget.height / 40,
                                bottom: widget.height / 35,
                                left: width / 90,
                                right: width / 90),
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Text(
                                    _bodies[index]['name'],
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: widget.height / 26,
                                      letterSpacing: 2.5,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  !error
                                      ? Text(
                                          ('You weigh : ${weight.toStringAsFixed(2)} Kg'),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: widget.height / 40,
                                            letterSpacing: 2.5,
                                          ),
                                        )
                                      : Text(
                                          ('Your weight cannot be determined'),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: widget.height / 40,
                                            letterSpacing: 2.5,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.only(
                                top: widget.height / 40,
                                bottom: widget.height / 35,
                                left: width / 28,
                                right: width / 28),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationX(pi),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Gravity Pull: ',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Text(
                                          '${_bodies[index]['pull']} m/s',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.amberAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '1 Day: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Text(
                                          '${_bodies[index]['day']}',
                                          style: TextStyle(
                                            color: Colors.amberAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Temp Range: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Text(
                                          '${_bodies[index]['temp']}',
                                          style: TextStyle(
                                            color: Colors.amberAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Distance to Earth: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Text(
                                          '${_bodies[index]['dis']}',
                                          style: TextStyle(
                                            color: Colors.amberAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Space Missions: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Text(
                                          '${_bodies[index]['missions']}',
                                          style: TextStyle(
                                            color: Colors.amberAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: widget.height / 20),
          height: widget.height / 16,
          width: width / 5,
          child: RaisedButton(
            color: Colors.blue[400],
            child: FittedBox(
              child: Text(
                'FLIP IT!',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 4,
                  fontSize: (orientation == Orientation.portrait)
                      ? widget.height / 15
                      : width / 75,
                ),
              ),
            ),
            onPressed: () {
              if (_animationStatus == AnimationStatus.dismissed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            },
          ),
        ),
      ],
    );
  }
}
