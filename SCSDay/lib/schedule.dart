import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF1d3557),
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
                          'assets/clock_bold.png',
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Material(
                            color: Colors.transparent,
                            child: Text("Schedule Modifier",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 30,
                                    color: Colors.white))),
                      ],
                    )),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFF1d3557),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "2H",
                            style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 20,
                                color: Colors.white),
                          ))),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "2 Hour Delay Schedule",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold', fontSize: 20),
                      ),
                    ],
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFFff483b),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Image.asset(
                            'assets/refresh.png',
                            color: Colors.white,
                          ))),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Reset Schedule To Normal",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold', fontSize: 20),
                      ),
                    ],
                  ))),
        ]),
      ),
    );
  }
}
