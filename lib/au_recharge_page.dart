import 'package:flutter/material.dart';
import 'package:flutter_module2/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common_widget.dart';
import 'package:flutter/services.dart';


class RechargeDashBoard extends StatefulWidget {
  const RechargeDashBoard({Key? key}) : super(key: key);


  static const platform = MethodChannel('samples.flutter.dev');

  @override
  State<RechargeDashBoard> createState() => _RechargeDashBoardState();
}

class _RechargeDashBoardState extends State<RechargeDashBoard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringValuesSF();
  }


  // Future<void> _callMethodChannel(BuildContext context, String method, String args) async {
  Future<void> _callMethodChannel(BuildContext context, String method,
      [ dynamic arguments ]) async {
    // DartPluginRegistrant.ensureInitialized();
    String batteryLevel;
    try {
      // final int result = await platform.invokeMethod('getBatteryLevel','my args');
      final int result = await RechargeDashBoard.platform.invokeMethod(
          method, arguments);
      Navigator.pop(context);
    } on PlatformException catch (e) {

    }
  }

  String _accessToken = 'na';

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? accessToken = 'na';
    if (prefs.containsKey('accessToken'))
      accessToken = prefs.getString('accessToken');

    // return accessToken;
    setState(() {
      _accessToken = accessToken!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: () {
          // _callMethodChannel(context, 'ScreenCallback', 'value from second screen');
          _callMethodChannel(context, 'ScreenCallback', <String, dynamic>{
            'second': 'value from second screen',
          });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => MyHomePage1(title: 'data from screen 1',)),
          // );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: IconButton(
          // icon: Icon(Icons.arrow_back),
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff000000),
          ),
          // onPressed: () { exit(0)},
          onPressed: () => SystemNavigator.pop(),
          // onPressed: () => Navigator.of(context).pop(),
          // onPressed: () => Navigator.pushReplacementNamed(context, "/first"),
        ),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          // getStringValuesSF(),
          _accessToken,
          // "FASTag",
          style: TextStyle(color: Color(0xff3B3B3B)),
        ),
        backgroundColor: Color(0xffffffff),
      ),
      body: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.fromLTRB(16, 24, 16, 0),
            color: Color(0xff3B3B3B),
            child: Container(
              width: double.infinity,
              height: 180,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 22, 10, 0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: getTextView('Honda City (Office car back)',
                            20.00, FontWeight.bold, Colors.white)
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: getTextView(
                            'MH xx xx 1234', 20.00, FontWeight.normal, Colors.white)
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: getTextView('₹200.67 ', 20.00, FontWeight.bold, Colors.white)
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
