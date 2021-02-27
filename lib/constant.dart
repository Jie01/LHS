import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle ktext = TextStyle(
  fontSize: 16,
  shadows: [
    Shadow(
      offset: Offset(1, 1),
      blurRadius: 2,
      color: Colors.black54,
    ),
  ],
);

TextStyle klocatext = TextStyle(
  color: Color(0xff575757),
  fontSize: 30,
  shadows: [
    Shadow(
      offset: Offset(1, 1),
      blurRadius: 2,
      color: Colors.black54,
    ),
  ],
);

TextStyle kbtntext = TextStyle(
  color: Colors.grey,
  fontSize: 25,
);

TextStyle kactivebtn = TextStyle(
  color: Colors.black,
  fontSize: 25,
);

TextStyle kblack = TextStyle(
  color: Colors.black,
);

TextStyle kprimarytext = TextStyle(
  color: Colors.yellow,
  fontSize: 30,
  shadows: [
    Shadow(
      offset: Offset(1, 1),
      blurRadius: 2,
      color: Colors.black54,
    ),
  ],
);

class Btn extends StatelessWidget {
  const Btn({
    Key key,
    @required this.haveplace,
    @required this.press,
    this.text,
  }) : super(key: key);

  final bool haveplace;
  final Function press;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: FlatButton(
        color: haveplace ? Colors.yellow : Color(0xffdddddd),
        onPressed: press,
        child: Text(
          text,
          style: haveplace ? kactivebtn : kbtntext,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.3,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(1, 2),
            blurRadius: 3,
          )
        ],
      ),
    );
  }
}
