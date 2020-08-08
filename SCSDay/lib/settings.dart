import 'package:flutter/material.dart';
import 'notifications.dart';
import 'report.dart';
import 'schedule.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
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
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 30),
                    child: Text(
                      "Settings",
                      style:
                          TextStyle(fontFamily: 'Poppins-Bold', fontSize: 30),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 100),
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
                Padding(
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
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 220),
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
                    bottom: 20, child: Text("Created By Jack Patterson")),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
