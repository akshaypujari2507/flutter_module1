
import 'package:flutter/material.dart';
import 'package:flutter_module1/extensions/text_extension.dart';
import 'package:flutter_module1/models/user.dart';
import 'package:flutter_module1/network/dio_client.dart';
import 'package:flutter_module1/widgets/data_input_field.dart';
import 'package:flutter_module1/widgets/output_error.dart';
import 'package:flutter_module1/widgets/output_panel.dart';
import 'package:flutter_module1/widgets/radio_input_field.dart';


class POSTMethodTile extends StatefulWidget {
  const POSTMethodTile({Key? key, required this.dioClient}) : super(key: key);
  final DioClient dioClient;

  @override
  State<POSTMethodTile> createState() => _POSTMethodTileState();
}

class _POSTMethodTileState extends State<POSTMethodTile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Gender gender = Gender.male;
  Status status = Status.active;

  bool isLoading = false;
  User? createdUser;
  String? error;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('POST Method'),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: const Text('Name:').fontSize(16)),
            Expanded(
              flex: 3,
              child: DataInputField(
                controller: _nameController,
                inputType: TextInputType.text,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(flex: 2, child: const Text('Email:').fontSize(16)),
            Expanded(
              flex: 3,
              child: DataInputField(
                controller: _emailController,
                inputType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(flex: 2, child: const Text('Gender:').fontSize(16)),
            Expanded(
              flex: 3,
              child: GenderRadioInputField(
                genderValue: gender,
                onChanged: (value) => setState(() => gender = value!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(flex: 2, child: const Text('Status:').fontSize(16)),
            Expanded(
              flex: 3,
              child: StatusRadioInputField(
                statusValue: status,
                onChanged: (value) => setState(() => status = value!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () async {
            setState(() => isLoading = true);
            final user = User(
              name: _nameController.text,
              email: _emailController.text,
              // gender: _$GenderEnumMap[gender],
              gender: 'male',
              status: 'active',
              // status: status.toString(),
            );

            try {
              final responseUser =
              await widget.dioClient.createUser(user: user);
              setState(() => createdUser = responseUser);
            } catch (err) {
              setState(() => error = err.toString());
            }

            setState(() => isLoading = false);
          },
          child: const Text('POST'),
        ),
        const SizedBox(height: 10.0),
        isLoading
            ? const OutputPanel(showLoading: true)
            : createdUser != null
            ? OutputPanel(user: createdUser)
            : error != null
            ? OutputError(errorMessage: error!)
            : const OutputPanel(),
        const SizedBox(height: 10.0),
      ],
    );
  }

}