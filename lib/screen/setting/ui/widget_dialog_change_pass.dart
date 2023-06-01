import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../@core/local_model/change_password_model.dart';
import '../../../@share/values/colors.dart';
import '../../../@share/values/styles.dart';
import '../../../@share/widgets/flushbar_custom.dart';
import '../../../@share/widgets/text_field_custom.dart';

class WidgetDialogChangePass extends StatefulWidget {
  const WidgetDialogChangePass({super.key, required this.onTap});
  final Function(ChangePasswordModel) onTap;
  @override
  State<WidgetDialogChangePass> createState() => _WidgetDialogChangePassState();
}

class _WidgetDialogChangePassState extends State<WidgetDialogChangePass> {
  TextEditingController oldPassCtrl = TextEditingController(text: '');
  TextEditingController newPassCtrl = TextEditingController(text: '');
  TextEditingController reNewPassCtrl = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: AssetImage('assets/images/bg_delete_chat.webp'),
              fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Change Password',
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
          textFieldChangePassCustom(
              hintText: 'Current password', controller: oldPassCtrl),
          const SizedBox(
            height: 15,
          ),
          textFieldChangePassCustom(
              hintText: 'New password', controller: newPassCtrl),
          const SizedBox(
            height: 15,
          ),
          textFieldChangePassCustom(
              hintText: 'Re-new password', controller: reNewPassCtrl),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TouchableOpacity(
                  onTap: () {
                    if (newPassCtrl.text == '' ||
                        oldPassCtrl.text == '' ||
                        reNewPassCtrl.text == '') {
                      showFlushBar(context,
                          msg: 'Field Empty !!', status: FLUSHBAR_ERROR);
                      return;
                    }
                    if (newPassCtrl.text != reNewPassCtrl.text) {
                      showFlushBar(context,
                          msg: 'New password and Re-new password not same !!',
                          status: FLUSHBAR_ERROR);
                      return;
                    }
                    widget.onTap(ChangePasswordModel(
                        currentPassword: oldPassCtrl.text,
                        newPassword: newPassCtrl.text));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50), color: green),
                    child: Text(
                      'Yes',
                      style: titleStyle.copyWith(
                          fontSize: 16, color: Colors.white),
                    ),
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
