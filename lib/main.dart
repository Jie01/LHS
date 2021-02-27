import 'package:flutter/material.dart';
import 'package:leavehomesafe/constant.dart';
import 'package:leavehomesafe/finish.dart';
import 'package:leavehomesafe/qrcode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "偽·安心出行",
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff12B188),
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool haveplace = false;
  String location = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "我想去",
            style: ktext,
          ),
          TextFormField(
            textAlign: TextAlign.center,
            style: kprimarytext,
            onChanged: (v) {
              location = v;
              setState(() {
                if (location != "") {
                  haveplace = true;
                } else {
                  haveplace = false;
                }
              });
            },
            decoration: InputDecoration(
              hintText: "輸入地址",
              hintStyle: klocatext,
            ),
          ),
          Spacer(),
          Btn(
            haveplace: haveplace,
            text: "話去就去！",
            press: () {
              if (haveplace) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Finish(
                              location: location,
                            )));
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QrCode()));
                },
                child: Text(
                  "掃描二維碼",
                  style: ktext,
                ),
              ),
              Text(
                "  |  ",
                style: ktext,
              ),
              GestureDetector(
                child: Text(
                  "相機設定",
                  style: ktext,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
