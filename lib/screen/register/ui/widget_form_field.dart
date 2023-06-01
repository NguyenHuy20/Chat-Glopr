import 'package:chat_glopr/@share/values/styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../@share/widgets/text_field_custom.dart';

class WidgetFormField extends StatefulWidget {
  const WidgetFormField({
    super.key,
    required this.fullNameController,
    required this.userNameController,
    required this.identityController,
    required this.passwordController,
    required this.genderController,
    required this.rePasswordController,
  });
  final TextEditingController fullNameController;
  final TextEditingController userNameController;
  final TextEditingController identityController;
  final TextEditingController passwordController;
  final TextEditingController genderController;
  final TextEditingController rePasswordController;

  @override
  State<WidgetFormField> createState() => _WidgetFormFieldState();
}

class _WidgetFormFieldState extends State<WidgetFormField> {
  final List<String> items = [
    'Male',
    'Female',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Wrap(runSpacing: 18, children: [
      textFormFieldCustom(
          labelText: 'Full name', controller: widget.fullNameController),
      textFormFieldCustom(
          labelText: 'Username', controller: widget.userNameController),
      textFormFieldCustom(
          labelText: 'Email', controller: widget.identityController),
      textFormFieldPasswordCustom(
          obscureText: true,
          labelText: 'Password',
          controller: widget.passwordController),
      textFormFieldPasswordCustom(
          obscureText: true,
          labelText: 'Re-password',
          controller: widget.rePasswordController),
      phoneFormFieldCustom(
        labelText: 'Phone',
      ),
      DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            'Gender',
            style: appStyle,
            overflow: TextOverflow.ellipsis,
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: appStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              widget.genderController.text = value?.toUpperCase() ?? '';
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.transparent,
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 20,
            iconEnabledColor: Colors.black,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 330,
            padding: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      )
    ]);
  }
}
