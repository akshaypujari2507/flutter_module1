import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_module1/common_widget.dart';
import 'package:flutter_module1/palette.dart';
import 'package:flutter_module1/views/home_screen_network.dart';
import 'package:flutter_module2/main.dart';
import 'au_recharge_page.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo First',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        // primarySwatch: Colors.blue,
        primarySwatch: generateMaterialColor(Palette.primary),
      ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page First'),
        initialRoute: "/first",
        routes: {
          "/first": (context) => const MyHomePage(title: 'Flutter Demo Home Page First'),
          // "/fastag": (context) => Navigator.pushNamed(context, '/second'),
          "/fastag": (context) => RechargeDashBoard(),
          "/secondScreen": (context) => MyHomePage1(title: 'data from screen 1',),
          "/homeScreenNetwork": (context) => HomeScreenNetwork(),
          // "/home": (context) => HomeScreenFB(),
          // "/billpay": (context) => BillPayScreen(),
          // "/fastag": (context) => RechargeDashBoard(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String response="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DartPluginRegistrant.ensureInitialized();
    //
    _getTempToken('getTempToken');
  }

  static const platform = MethodChannel('samples.flutter.dev');

  String _batteryLevel = 'Unknown battery level.';

  // Future<void> _callMethodChannel(BuildContext context, String method, String args) async {
  //_callMethodChannel(context, 'callback', 'callback value $_counter');
  Future<void> _callMethodChannel(BuildContext context, String method, [ dynamic arguments ]) async {
    // DartPluginRegistrant.ensureInitialized();
    String batteryLevel;
    try {
      // final int result = await platform.invokeMethod('getBatteryLevel','my args');
      final int result = await platform.invokeMethod(method, arguments);
      Navigator.pop(context);
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  String _tempToken = "";

  Future<void> _getTempToken(String method, [ dynamic arguments ]) async {
    String tempToken = "Flutter Demo Home Page First";
    try {
      // final result = await platform.invokeMethod<Map<String, dynamic>>(method, arguments);
      final result = await platform.invokeMapMethod(method, arguments);
      tempToken = result!['tempToken'] as String;
      final cif = result!['cif'] as String;
      final mobile = result!['mobile'] as String;

      _getAccessToken(tempToken);
      // tempToken = tempToken + ' | ' + cif + ' | ' + mobile;
      // tempToken = await platform.invokeMethod(method, arguments);
    } on PlatformException catch (e) {

    }

    setState(() {
      _tempToken = tempToken;
    });

  }

  Future<void> _callBackHost() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('callback');
      // batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      // batteryLevel = "Failed to get battery level: '${e.message}'.";
    }


  }

    void _incrementCounter() {
    setState(() {
      response;
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  addStringToSF(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', data);
  }

  Future<String?> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? accessToken = 'na';
    if (prefs.containsKey('accessToken'))
      accessToken = prefs.getString('accessToken');
    return accessToken;
  }

  removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(key);
    //Remove bool
    // prefs.remove("boolValue");
    //Remove int
    // prefs.remove("intValue");
    //Remove double
    // prefs.remove("doubleValue");
  }

  _getAccessToken(String tempToken) {
    //call getAccessToken api

    //onSuccess store accessToken
    String accessToken = tempToken.replaceAll('Temp', 'Temp/Access');
    addStringToSF(accessToken);

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
      // appBar: AppBar(
      //   elevation: 0,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   // title: Text(widget.title),
      //   title: Text(_tempToken),
      // ),
      appBar: getAppBar(_tempToken, Icon(
        Icons.arrow_back,
        color: Palette.primaryPurple,
      ), 0, 0, context, Palette.primaryPurple),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   // '$_counter',
            //   '$_batteryLevel',
            //   style: Theme.of(context).textTheme.headline4,
            // ),

            RaisedButton(
              //     disabledColor: Colors.red,
              // disabledTextColor: Colors.black,
              padding: const EdgeInsets.all(20),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                _counter++;
                _callMethodChannel(context, 'callback', 'callback value $_counter');
              },
              child: const Text('Send callback to host'),
            ),

            SizedBox(
              height: 10,
            ),

            RaisedButton(
              //     disabledColor: Colors.red,
              // disabledTextColor: Colors.black,
              padding: const EdgeInsets.all(20),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                _counter++;
                _callMethodChannel(context, 'callback', 'callback value $_counter');
                Navigator.pushNamed(context, '/fastag');
              },
              child: const Text('Second screen'),
            ),

            SizedBox(
              height: 10,
            ),

            RaisedButton(
              //     disabledColor: Colors.red,
              // disabledTextColor: Colors.black,
              padding: const EdgeInsets.all(20),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                _counter++;
                Navigator.pushNamed(context, '/homeScreenNetwork');
              },
              child: const Text('Network call screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: () {
          // _callBackHost();
          // _callMethodChannel(context, 'ScreenCallback', 'ScreenCallback value $_counter');
          // _callMethodChannel(context, 'ScreenCallback', <String, dynamic>{
          //   'first': 'ScreenCallback value $_counter',
          //   'second': 'ScreenCallback value ${_counter + _counter}',
          // });
          // _incrementCounter();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RechargeDashBoard()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
