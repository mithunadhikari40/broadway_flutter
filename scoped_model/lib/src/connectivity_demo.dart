import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityDemo extends StatefulWidget {
  @override
  _ConnectivityDemoState createState() => _ConnectivityDemoState();
}

class _ConnectivityDemoState extends State<ConnectivityDemo> {
  String conResult = 'No connection';

  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      listenConnectivity(result);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Connectivity test"),
        ),
        body: Center(child: Text(conResult)),
      ),
    );
  }

  void listenConnectivity(ConnectivityResult result)  async{
    var connectivityResult = await (Connectivity().checkConnectivity());

    Fluttertoast.showToast(msg: "Current network connection ${connectivityResult}");

    if (result == ConnectivityResult.wifi) {
      setState(() {
        conResult = 'Connected to wifi';
      });
    }
    if (result == ConnectivityResult.mobile) {
      setState(() {
        conResult = 'Connected to mobile data';
      });
    }
    if (result == ConnectivityResult.none) {
      setState(() {
        conResult = 'No connection';
      });
    }
  }
}
