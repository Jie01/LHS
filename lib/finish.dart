import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:leavehomesafe/main.dart';

import 'constant.dart';

class Finish extends StatefulWidget {
  final String location;

  const Finish({Key key, this.location}) : super(key: key);
  @override
  _FinishState createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  bool autoleave = true;

  bool leavetime = true;
  int selectedTime = 4;

  String time =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute}' : DateTime.now().minute}";

  DateTime dateTime = DateTime.now();

  datenum() {
    List<int> month = [1, 3, 5, 7, 8, 10, 12];

    if (DateTime.now().month == 2) {
      if (DateTime.now().year % 4 == 0) {
        return 29;
      } else {
        return 28;
      }
    } else if (month.contains(DateTime.now().month)) {
      return 31;
    } else {
      return 30;
    }
  }

  Future<void> leave() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                '你是什麼時候離開?',
                style: kblack,
              ),
              Spacer(),
              IconButton(
                color: Colors.black,
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(
                            DateTime.now().year - 5,
                            1,
                            1,
                            00,
                            00,
                          ),
                          maxTime: DateTime(
                              DateTime.now().year + 3, 12, datenum(), 23, 59),
                          onConfirm: (date) {
                        setState(() {
                          dateTime = date;
                        });

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.zh);
                    },
                    child: Text(
                      '選擇離開時間',
                      style: TextStyle(color: Colors.blue),
                    )),
                Text(
                  dateTime.toString().substring(0, 16),
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              color: Colors.yellow,
              child: Text(
                "確認",
                style: kblack,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> changeTime() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ...List.generate(24, (index) {
                  return InkWell(
                    onTap: () {
                      selectedTime = index + 1;
                      this.setState(() {});
                    },
                    child: TimeTile(
                      index: index + 1,
                      selected: selectedTime,
                    ),
                  );
                }),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              color: Colors.yellow,
              child: Text(
                "確認",
                style: kblack,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              "你已進入場所",
              style: ktext,
            ),
            SizedBox(height: 7),
            Text(
              widget.location,
              style: kprimarytext,
            ),
            SizedBox(height: 7),
            Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              child: Image.asset(
                "images/tick.png",
                width: 150,
                height: 150,
                alignment: Alignment.center,
              ),
              width: double.infinity,
            ),
            Spacer(
              flex: 2,
            ),
            Row(
              children: [
                Checkbox(
                  checkColor: Color(0xff12b188),
                  activeColor: Colors.white,
                  value: leavetime,
                  onChanged: (v) {
                    setState(() {
                      leavetime = v;
                    });
                  },
                ),
                Text("${selectedTime.toString()}小時後自動離開"),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    changeTime();
                  },
                  child: Text("變更"),
                ),
              ],
            ),
            Btn(
              haveplace: true,
              text: "離開",
              press: () {
                leave();
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '當你離開時請緊記按"離開"',
              style: ktext,
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class TimeTile extends StatelessWidget {
  final int index, selected;

  const TimeTile({Key key, this.index, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "+$index小時",
              style: kblack,
            ),
            Spacer(),
            index == selected
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : Container(),
          ],
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      ],
    );
  }
}
