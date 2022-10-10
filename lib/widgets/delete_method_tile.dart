
import 'package:flutter/material.dart';
import 'package:flutter_module1/extensions/text_extension.dart';
import 'package:flutter_module1/network/dio_client.dart';
import 'package:flutter_module1/widgets/data_input_field.dart';
import 'package:flutter_module1/widgets/output_error.dart';
import 'package:flutter_module1/widgets/output_panel.dart';
import 'package:flutter_module1/widgets/output_success.dart';

class DELETEMethodTile extends StatefulWidget {
  const DELETEMethodTile({Key? key, required this.dioClient}) : super(key: key);
  final DioClient dioClient;

  @override
  State<DELETEMethodTile> createState() => _DELETEMethodTileState();
}

class _DELETEMethodTileState extends State<DELETEMethodTile> {
  final TextEditingController _idController = TextEditingController();
  int? userId;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('DELETE Method'),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
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
            : FutureBuilder<void>(
          future: widget.dioClient.deleteUser(id: userId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const OutputPanel(showLoading: true);
            } else if (snapshot.hasError) {
              return OutputError(errorMessage: snapshot.error.toString());
            } else {
              return const OutputSuccess(
                  successMessage: 'User deleted successfully!');
            }
          },
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}