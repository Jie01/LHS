import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leavehomesafe/finish.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  final String code =
      "HKEN:0WHBvLDSaeyJtZXRhZGF0YSI6eyJ0eXBlRW4iOiJTdG9yZXMvU2hvcHBpbmcgTWFsbHMiLCJ0eXBlWmgiOiLllYblupcv5ZWG5aC0In0sIm5hbWVaaCI6IuiNg+aWsOWkqeWcsCIsIm5hbWVFbiI6IkNpdHlXYWxrIiwidHlwZSI6IklNUE9SVCIsImhhc2giOiJhZGJlYzQxZjBjODI2ZTAwZjU0NWI2MDIxZWQ3MTMyNTJlNDRkMTAyMTAyZTk5MzAxYWU5NjhiZDBkMDQ1NGQzIn0=";

  @override
  void initState() {
    parseJson(code.substring(14));
    super.initState();
  }

  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  final a = {
    "nameZh": "abcd",
    "nameEn": "cdef",
  };

  Map<String, dynamic> parseJson(String response) {
    var normalized = base64Url.normalize(response);
    var resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    print("${payloadMap} is payload map");
    return payloadMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("掃描二維碼"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? GestureDetector(
                      onLongPress: () async {
                        await Clipboard.setData(
                                new ClipboardData(text: result.code))
                            .then((value) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text(" copied to clipboard")));
                        });
                      },
                      child: Text('${result.code}'),
                    )
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null && result.code.startsWith("HKEN:")) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Finish(
                        location:
                            parseJson(result.code.substring(14))["nameZh"],
                      )));
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
