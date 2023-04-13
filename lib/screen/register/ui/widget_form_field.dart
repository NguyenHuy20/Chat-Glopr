import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../@share/widgets/text_field_custom.dart';

class WidgetFormField extends StatelessWidget {
  const WidgetFormField(
      {super.key,
      required this.fullNameController,
      required this.userNameController,
      required this.identityController,
      required this.passwordController,
      required this.genderController,
      required this.rePasswordController});
  final TextEditingController fullNameController;
  final TextEditingController userNameController;
  final TextEditingController identityController;
  final TextEditingController passwordController;
  final TextEditingController genderController;
  final TextEditingController rePasswordController;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 18,
      children: [
        textFormFieldCustom(
            labelText: 'Full name', controller: fullNameController),
        textFormFieldCustom(
            labelText: 'Username', controller: userNameController),
        textFormFieldCustom(labelText: 'Email'),
        textFormFieldPasswordCustom(
            obscureText: true,
            labelText: 'Password',
            controller: passwordController),
        textFormFieldPasswordCustom(
            obscureText: true,
            labelText: 'Re-password',
            controller: rePasswordController),
        phoneFormFieldCustom(
            labelText: 'Phone', controller: identityController),
        textFormFieldCustom(labelText: 'Gender', controller: genderController),
      ],
    );
  }
}
