import 'package:SCSDay/suggest.dart';
import 'package:flutter/material.dart';
import 'notifications.dart';
import 'report.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).canvasColor;

    getColor() {
      print(color);
      return color;
    }

    changeIconColor() {
      if (getColor() == Color(0xFF111111)) {
        return Colors.white;
      }
    }

    return Scaffold(
        body: Material(
      child: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                ),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/back.png',
                      color: changeIconColor(),
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 40),
                    child: Text(
                      "Settings",
                      style:
                          TextStyle(fontFamily: 'Poppins-Bold', fontSize: 30),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Notifications(),
                              ),
                            ),
                        child: Row(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFF004DB2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  'assets/bell.png',
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold', fontSize: 20),
                            ),
                          ],
                        ))),
                /*Padding(
                    padding: EdgeInsets.only(top: 160),
                    child: GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Schedule(),
                              ),
                            ),
                        child: Row(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFF1d3557),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  'assets/clock.png',
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Schedule Modifier",
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold', fontSize: 20),
                            ),
                          ],
                        ))), */
                Padding(
                    padding: EdgeInsets.only(top: 180), //220
                    child: GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Suggest(),
                              ),
                            ),
                        child: Row(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFF3480eb),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  'assets/edit.png',
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Suggest a Feature",
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold', fontSize: 20),
                            ),
                          ],
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 240), //220
                    child: GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Report(),
                              ),
                            ),
                        child: Row(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  'assets/alert-triangle.png',
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Report An Issue",
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold', fontSize: 20),
                            ),
                          ],
                        ))),
                Positioned(
                    bottom: 0,
                    child: Text(
                      "Created By Jack Patterson",
                      style: TextStyle(fontFamily: 'Poppins-Light'),
                    )),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
