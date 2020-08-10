import 'package:SCSDay/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'settings.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCSDay',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      darkTheme:
          ThemeData(brightness: Brightness.dark, canvasColor: Color(0xFF111111)
              // additional settings go here
              ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  void _showNotification() async {
    var state = await _getBoolFromprefs();
    var period = await _getperiodFromPrefs();
    var hour = await _getHourFromPrefs();
    var min = await _getMinutesFromPrefs();
    if (state) await _demoNotification(period, hour, min);
  }

  Future<void> _demoNotification(bool state, double hour, double min) async {
    var time;
    if (state) {
      time = Time(hour.round() + 12, min.round(), 0);
    }
    if (!state) {
      time = Time(hour.round(), min.round(), 0);
    }
    print(time.hour);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(0, 'show daily title',
        'Daily notification', time, platformChannelSpecifics);
  }

  //Method for showing the date picker

  /*Future getDay() async {
    final rawUrl =
        'https://portal.smithtown.k12.ny.us/bulletin/80/?date=3/3/2020';
    print(rawUrl);
    final webScraper = WebScraper('https://portal.smithtown.k12.ny.us');
    final endpoint =
        rawUrl.replaceAll(r'https://portal.smithtown.k12.ny.us', '');
    if (await webScraper.loadWebPage(endpoint)) {
      final titleElements = webScraper.getElement(
          '#publicBulletin > div#container > div#content > div#content-main > div > p > font > b > b > font',
          []);
      if (titleElements == 'Today is an "A" Day') {
        setState(() {
          textSize = 200;
        });
        return "A";
      } else if (titleElements == 'Today is an "B" Day') {
        setState(() {
          textSize = 200;
        });
        return "B";
      } else {
        setState(() {
          textSize = 40;
        });
        return "Not A School Day";
      }
    }
  }


  

*/

  Future _getDay() async {
    var response =
        await http.get(Uri.encodeFull('http://127.0.0.1:5000/'), headers: {
      "Accept": "application/json",
    });

    setState(() {
      _day = response.body;
    });
  }

  Future<bool> _getBoolFromprefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _bool = prefs.getBool('bool');
    if (_bool == null) {
      return false;
    }
    return _bool;
  }

  Future<bool> _getperiodFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _state = prefs.getBool('isPM');

    return _state;
  }

  Future<double> _getHourFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _hour = prefs.getDouble('hour');
    if (_hour == null) {
      return 7;
    }
    return _hour;
  }

  Future<double> _getMinutesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _minute = prefs.getDouble('minute');
    print(_minute);
    if (_minute == null) {
      return 20;
    }
    return _minute;
  }

  String _day = "";

  Timer timer;

  @override
  void initState() {
    super.initState();
    _getDay();
    _showNotification();
    _getBoolFromprefs();
    _getperiodFromPrefs();
    _getMinutesFromPrefs();
    _getHourFromPrefs();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _getBoolFromprefs();
      _getperiodFromPrefs();
      _getMinutesFromPrefs();
      _getHourFromPrefs();
      _showNotification();
    });

    initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new MyApp()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).canvasColor;

    getColor() {
      print(color);
      return color;
    }

    changeColor() {
      if (getColor() == Color(0xFF111111)) {
        return Colors.white;
      }
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: SafeArea(
      child: Stack(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12.0, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Current Date: ' + DateFormat.yMMMd().format(DateTime.now()),
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-SemiBold',
                      color: changeColor()),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20, top: 16),
                child: GestureDetector(
                    child: Image.asset(
                      'assets/settings.png',
                      color: changeColor(),
                    ),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(),
                          ),
                        )),
              )),
          Center(
            child: Text(
              '$_day',
              style: TextStyle(
                  fontFamily: 'Poppins-Bold',
                  fontSize: 50,
                  color: changeColor()),
            ),
          ),
        ],
      ),
    ));
  }
}
