
import 'package:flutter/material.dart';
import 'package:flutter_module1/network/dio_client.dart';
import 'package:flutter_module1/widgets/delete_method_tile.dart';
import 'package:flutter_module1/widgets/get_method_tile.dart';
import 'package:flutter_module1/widgets/post_method_tile.dart';

class HomeScreenNetwork extends StatelessWidget {
  const HomeScreenNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DioClient dioClient = DioClient();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Example'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GETMethodTile(dioClient: dioClient),
            POSTMethodTile(dioClient: dioClient),
            DELETEMethodTile(dioClient: dioClient),
          ],
        ),
      ),
    );
  }
}
