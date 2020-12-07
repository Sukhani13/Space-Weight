import 'package:flutter/material.dart';
import 'package:weight/bodies.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weight = TextEditingController();
  String earthWeight = '0';
  bool iskg = true;
  String weightValue = 'Kg';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/space.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'What is your Weight?',
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: (orientation == Orientation.portrait)
                          ? height / 30
                          : width / 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height / 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width / 3,
                      height: height / 16,
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[400],
                          hoverColor: Colors.blue[300],
                          border: InputBorder.none,
                          hintText: 'Enter your weight',
                          hintStyle: TextStyle(
                            wordSpacing: 1.5,
                            letterSpacing: 1.1,
                            color: Colors.white,
                            fontSize: (orientation == Orientation.portrait)
                                ? height / 75
                                : width / 70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        controller: weight,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            if (value.trim() == '')
                              earthWeight = '0';
                            else if (iskg) {
                              earthWeight = value;
                            } else {
                              double datum;
                              try {
                                datum = double.parse(value) * 0.45359237;
                              } catch (e) {
                                earthWeight = datum.toString();
                              }
                              earthWeight = datum.toString();
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      height: height / 16,
                      width: width / 8,
                      color: Colors.blue[400],
                      child: RaisedButton(
                        color: Colors.blueGrey,
                        child: FittedBox(
                          child: Text(
                            iskg ? 'kg' : 'lbs',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.4,
                              fontWeight: FontWeight.bold,
                              fontSize: (orientation == Orientation.portrait)
                                  ? height / 75
                                  : width / 70,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            weight.text = '';
                            earthWeight = '0';
                            iskg = !iskg;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: height / 18),
                  width: width / 1.4,
                  child: CelestialBodies(
                    height: height,
                    weight: earthWeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
