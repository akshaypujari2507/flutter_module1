import 'package:flutter/material.dart';

import 'common_widget.dart';

class RechargeDashBoard2 extends StatelessWidget {
  const RechargeDashBoard2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: () {

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
          onPressed: () => Navigator.of(context).pop(),
          // onPressed: () => Navigator.pushReplacementNamed(context, "/first"),
        ),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "FASTag second app",
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
                            20.00, FontWeight.bold)
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: getTextView('MH xx xx 1234', 20.00, FontWeight.normal)
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: getTextView('₹200.67 ', 20.00, FontWeight.bold)
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
