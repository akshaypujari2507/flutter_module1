

import 'package:flutter/material.dart';
import 'package:flutter_module1/extensions/text_extension.dart';
import 'package:flutter_module1/models/user.dart';
import 'package:flutter_module1/network/dio_client.dart';
import 'package:flutter_module1/widgets/data_input_field.dart';
import 'package:flutter_module1/widgets/output_error.dart';
import 'package:flutter_module1/widgets/output_panel.dart';

class GETMethodTile extends StatefulWidget {
  const GETMethodTile({Key? key, required this.dioClient}) : super(key: key);
  final DioClient dioClient;

  @override
  State<GETMethodTile> createState() => _GETMethodTileState();
}

class _GETMethodTileState extends State<GETMethodTile> {
  final TextEditingController _idController = TextEditingController();
  int? userId;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('GET Method'),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Enter the ID of the user:').fontSize(16),
            SizedBox(
              width: 100,
              child: DataInputField(
                controller: _idController,
                inputType: TextInputType.number,
                onSubmitted: (id) => setState(() => userId = int.parse(id)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        userId == null
            ? const OutputPanel()
            : FutureBuilder<User?>(
          future: widget.dioClient.getUser(id: userId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const OutputPanel(showLoading: true);
            } else if (snapshot.hasError) {
              return OutputError(errorMessage: snapshot.error.toString());
            } else if (snapshot.hasData) {
              return OutputPanel(user: snapshot.data);
            } else {
              return const OutputPanel();
            }
          },
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}