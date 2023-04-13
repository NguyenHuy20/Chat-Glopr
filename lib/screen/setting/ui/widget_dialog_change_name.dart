import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../@share/values/colors.dart';
import '../../../@share/values/styles.dart';
import '../../../@share/widgets/text_field_custom.dart';

class WidgetDialogChangeName extends StatelessWidget {
  const WidgetDialogChangeName({super.key, required this.fullName});
  final String fullName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: AssetImage('assets/images/bg_delete_chat.webp'),
              fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Change Name',
            style: titleStyle.copyWith(fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).viewPadding.right + 200),
            child: const Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          textFieldChangeNameCustom(initValue: fullName),
          Expanded(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), color: green),
                  child: Text(
                    'Yes',
                    style:
                        titleStyle.copyWith(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TouchableOpacity(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: Text(
                      'Cancel',
                      style: titleStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
