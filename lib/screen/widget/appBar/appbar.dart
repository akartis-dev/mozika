import 'package:flutter/material.dart';
import 'package:mozika/utils/theme.dart';

class AppPlayerAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  late List<Widget> actions;

  AppPlayerAppBar({Key? key, required this.title, this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomTheme.black,
      centerTitle: true,
      elevation: 2,
      actions: actions,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
