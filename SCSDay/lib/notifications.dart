import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Notifications extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  Future<double> _getHourFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _hour = prefs.getDouble('hour');
    if (_hour == null) {
      return 7;
    }
    return _hour;
  }

  Future<bool> _getperiodFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _state = prefs.getBool('isPM');

    return _state;
  }

  Future<double> _getMinuteFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _minute = prefs.getDouble('minute');
    if (_minute == null) {
      return 20;
    }
    return _minute;
  }

  Future<bool> _getBoolFromprefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _bool = prefs.getBool('bool');
    if (_bool == null) {
      return false;
    }
    return _bool;
  }

  Future<void> setHour(double hour) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('hour', hour);
  }

  Future<void> setMinute(double min) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('minute', min);
  }

  Future<void> setBool(bool state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bool', state);
  }

  Future<void> setPeriod(bool state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPM', state);
  }

  bool _isSwitched = false;

  double _sliderMin = 7;
  double _sliderHour = 20;

  Color _amColor = Colors.black;
  Color _pmColor = Colors.black;

  final display = createDisplay(length: 2);

  double _saveopacity = 0;

  Future<void> _hourStartup() async {
    double lasthour = await _getHourFromPrefs();

    if (_sliderHour == null) {
      setState(() {
        _sliderHour = 7;
      });
    } else {
      setState(() {
        _sliderHour = lasthour;
      });
    }
  }

  Future<void> _minuteStartup() async {
    double lastMinute = await _getMinuteFromPrefs();

    if (_sliderMin == null) {
      setState(() {
        _sliderMin = 20;
      });
    } else {
      setState(() {
        _sliderMin = lastMinute;
      });
    }
  }

  Future<void> _boolStartup() async {
    bool state = await _getBoolFromprefs();

    setState(() {
      _isSwitched = state;
    });
  }

  Future<void> _periodStartup() async {
    bool state = await _getperiodFromPrefs();
    if (state == null) {
      state = false;
    }
    (state)
        ? setState(() {
            _pmColor = Color(0xFF004DB2);
            _amColor = Colors.black;
          })
        : setState(() {
            _amColor = Color(0xFF004DB2);
            _pmColor = Colors.black;
          });
  }

  saveSequence() {
// Here you can write your code

    setState(() {
      _saveopacity = 1;
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
// Here you can write your code

      setState(() {
        _saveopacity = 0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _hourStartup();
    _minuteStartup();
    _boolStartup();
    _periodStartup();
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
                    child: Image.asset(
                      'assets/back.png',
                      color: Colors.white,
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
                Text(
                  "Toggle Notifications",
                  style:
                      TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 20),
                ),
                CupertinoSwitch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                      setBool(value);
                      saveSequence();
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
                  setPeriod(false);
                  saveSequence();
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
                  setPeriod(true);
                  saveSequence();
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
              (display(_sliderMin).padLeft(2, '0')),
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
                        setHour(value);
                        saveSequence();
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
                        setMinute(value);
                        saveSequence();
                      });
                    })
              ],
            )),
        Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: AnimatedOpacity(
                                opacity: _saveopacity,
                                duration: Duration(milliseconds: 200),
                                child: Text(
                                  "Saved",
                                  style: TextStyle(
                                      color: Color(0xFF004DB2),
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 20),
                                ))))))),
      ],
    ))));
  }
}
