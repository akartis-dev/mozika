import 'package:flutter/material.dart';
import 'package:mozika/utils/theme.dart';

class BottomBarIcon extends StatefulWidget {
  IconData icon;
  String? label;
  int current;
  int order;
  Function onPressed;

  BottomBarIcon(
      {Key? key,
      required this.icon,
      this.label,
      required this.current,
      required this.onPressed,
      required this.order})
      : super(key: key);

  @override
  _BottomBarIconState createState() => _BottomBarIconState();
}

class _BottomBarIconState extends State<BottomBarIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                widget.onPressed(widget.order);
              },
              enableFeedback: false,
              icon: Icon(
                widget.icon,
                color: widget.current == widget.order
                    ? CustomTheme.primary
                    : Colors.white,
              )),
        ]);
  }
}
