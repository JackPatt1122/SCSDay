import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  bool _isSwitched = false;

  double _sliderMin = 0;
  double _sliderHour = 0;

  String _notifyBool;

  Color _amColor = Colors.black;
  Color _pmColor = Colors.black;

  final display = createDisplay(length: 2);

  double _notifyBoolOpacity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
            child: Container(
                child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF004DB2),
          ),
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 50),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 145, left: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/bell_bold.png',
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: Text("Notifications",
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 30,
                                  color: Colors.white))),
                    ],
                  ))
            ],
          ),
        ),
        Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: _notifyBoolOpacity,
                    child: Text(
                      "Toggle Notifications",
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold', fontSize: 20),
                    )),
                CupertinoSwitch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                  activeColor: Color(0xFF004DB2),
                ),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                child: Text(
                  "AM",
                ),
                style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 30,
                    color: _amColor),
              ),
              onTap: () {
                setState(() {
                  _amColor = Color(0xFF004DB2);
                  _pmColor = Colors.black;
                });
              },
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                child: Text(
                  "PM",
                ),
                style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 30,
                    color: _pmColor),
              ),
              onTap: () {
                setState(() {
                  _pmColor = Color(0xFF004DB2);
                  _amColor = Colors.black;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              display(_sliderHour),
              style: TextStyle(
                  color: Color(0xFF004DB2),
                  fontSize: 50,
                  fontFamily: 'Poppins-SemiBold'),
            ),
            Text(
              " : ",
              style: TextStyle(
                  color: Color(0xFF004DB2),
                  fontSize: 50,
                  fontFamily: 'Poppins-SemiBold'),
            ),
            Text(
              display(_sliderMin),
              style: TextStyle(
                  color: Color(0xFF004DB2),
                  fontSize: 50,
                  fontFamily: 'Poppins-SemiBold'),
            )
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 23),
                        child: Text(
                          "Hour",
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'Poppins-SemiBold'),
                        ))),
                Slider(
                    activeColor: Color(0xFF004DB2),
                    inactiveColor: Color(0xFF004DB2).withOpacity(.5),
                    value: _sliderHour,
                    min: 0,
                    max: 12,
                    divisions: 12,
                    label: _sliderHour.roundToDouble().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _sliderHour = value;
                      });
                    })
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 23),
                        child: Text(
                          "Minute",
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'Poppins-SemiBold'),
                        ))),
                Slider(
                    activeColor: Color(0xFF004DB2),
                    inactiveColor: Color(0xFF004DB2).withOpacity(.5),
                    value: _sliderMin,
                    min: 0,
                    max: 59,
                    divisions: 59,
                    label: _sliderMin.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _sliderMin = value;
                      });
                    })
              ],
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF004DB2),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins-SemiBold',
                      fontSize: 20),
                )),
              ),
            ))
      ],
    ))));
  }
}
