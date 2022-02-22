import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:mozika/utils/theme.dart';

import 'bottom_bar_icon.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final double height = 75;
  int current = 1;

  void onChangeHandler(int key) {
    setState(() {
      current = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GlassmorphicContainer(
          width: MediaQuery.of(context).size.width,
          height: height,
          borderRadius: 0,
          blur: 10,
          alignment: Alignment.bottomCenter,
          border: 0,
          linearGradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF47423c),
                Color(0xFF2a2a2a),
              ],
              stops: [
                0.1,
                1,
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.5),
              const Color((0xFFFFFFFF)).withOpacity(0.5),
            ],
          ),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: height - 15,
              child: Container(
                decoration: BoxDecoration(
                    color: CustomTheme.black,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomBarIcon(
                        current: current,
                        order: 1,
                        icon: Icons.home,
                        onPressed: onChangeHandler,
                        label: "Home"),
                    BottomBarIcon(
                        current: current,
                        order: 2,
                        icon: Icons.search,
                        onPressed: onChangeHandler,
                        label: "Home"),
                    BottomBarIcon(
                        current: current,
                        order: 3,
                        icon: Icons.favorite,
                        onPressed: onChangeHandler,
                        label: "Home"),
                    BottomBarIcon(
                        current: current,
                        order: 4,
                        icon: Icons.person,
                        onPressed: onChangeHandler,
                        label: "Home"),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
