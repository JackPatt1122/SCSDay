import 'package:SCSDay/settings.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What Day',
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
  DateTime _selectedDate;

  static DateTime now = DateTime.now();

  String day, month, year;

  double textSize = 200;

  String convertDateTimeDisplay() {
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = DateTime.now();
    final String formatted = serverFormater.format(displayDate);
    return formatted;
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
  @override
  void initState() {
    super.initState();
    day = convertDateTimeDisplay().split('-')[0].replaceAll(' ', '');
    month = convertDateTimeDisplay().split('-')[1];
    year = convertDateTimeDisplay().split('-')[2];
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 12.0, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Current Date: ' +
                        DateFormat.yMMMd().format(DateTime.now()),
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'Poppins-SemiBold'),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, top: 12),
                    child: GestureDetector(
                        child: Image.asset('assets/settings.png'),
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Settings(),
                              ),
                            )),
                  ))),
          /*Center(
            child: FutureBuilder<dynamic>(
              future: getDay(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData)
                  return Text('${snapshot.data}',
                      style: TextStyle(
                          fontSize: textSize,
                          fontFamily: 'Montserrat-SemiBold'));
                return Text("Loading",
                    style: TextStyle(
                        fontFamily: 'Montserrat-SemiBold',
                        fontSize: 15,
                        color: Colors.black));
              },
            ), 
          ),*/
        ],
      ),
    );
  }
}
