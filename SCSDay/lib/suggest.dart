import 'package:flutter/material.dart';
import 'package:mailer2/mailer.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Suggest extends StatefulWidget {
  @override
  _SuggestState createState() => _SuggestState();
}

class _SuggestState extends State<Suggest> {
  final _controller = TextEditingController();

  String emailState = "Submit";
  double _emailStateOpacity = 1;

  sendEmail() {
    if (_controller.text != "") {
      var options = new GmailSmtpOptions()
        ..username = 'jpattersonservices@gmail.com'
        ..password = 'dgqvoapbbxpjpfpr';

      var emailTransport = new SmtpTransport(options);

      // Create our mail/envelope.
      var envelope = new Envelope()
        ..recipients.add('jpattersonservices@gmail.com')
        ..subject =
            'SCSDay - Feature - ' + DateFormat.yMMMMd().format(DateTime.now())
        ..text = '$_controller.text'.substring(52).replaceAll(
            '├, selection: TextSelection(baseOffset: -1, extentOffset: -1, affinity: TextAffinity.downstream, isDirectional: false), composing: TextRange(start: -1, end: -1))).text',
            '');
      emailTransport
          .send(envelope)
          .then((envelope) => changeEmailState("Sent"));
    }
    if (_controller.text == "") {
      changeEmailState("Field Cant Be Empty");
    }
  }

  changeEmailState(String text) {
    setState(() {
      _emailStateOpacity = 0;
    });

    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        emailState = text;
      });
      Timer(const Duration(milliseconds: 600), () {
        setState(() {
          _emailStateOpacity = 1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF3480eb),
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
                          'assets/edit_bold.png',
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Material(
                            color: Colors.transparent,
                            child: Text("Suggest A Feature",
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
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Whats The Feature?",
                  style:
                      TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 20),
                )),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3480eb), width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    hintText: 'Feature:',
                    hintStyle: TextStyle(fontFamily: 'Poppins-SemiBold')),
                controller: _controller,
                maxLength: 100,
              )),
          GestureDetector(
              onTap: () => sendEmail(),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF3480eb),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 200),
                              opacity: _emailStateOpacity,
                              child: Text(
                                "$emailState",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 20),
                              ))),
                    ),
                  ))),
        ]),
      ),
    );
  }
}
