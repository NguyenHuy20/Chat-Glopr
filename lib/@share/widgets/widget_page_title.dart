import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../values/styles.dart';

class WidgetPageTitle extends StatelessWidget {
  const WidgetPageTitle(
      {Key? key,
      this.isBack = true,
      this.isPadding = true,
      required this.title,
      this.iconRight,
      this.isClose = false})
      : super(key: key);
  final bool? isBack;
  final bool isPadding;
  final String title;
  final Widget? iconRight;
  final bool isClose;

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingDevice = MediaQuery.of(context).viewPadding;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          top: paddingDevice.top + 10,
          left: isPadding ? 16 : 0,
          right: isPadding ? 16 : 0,
          bottom: 12),
      child: Stack(
        children: [
          isBack!
              ? TouchableOpacity(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color: Colors.transparent,
                    width: 50,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        isClose ? Icons.clear_rounded : Icons.arrow_back_ios,
                        size: isClose ? 22 : 20,
                      ),
                    ),
                  ),
                )
              : const SizedBox(width: 20),
          Center(
              child: Text(title, style: bodyParagraph1.copyWith(fontSize: 18))),
          Align(
              alignment: Alignment.centerRight,
              child: iconRight ?? const SizedBox(width: 20))
        ],
      ),
    );
  }
}
