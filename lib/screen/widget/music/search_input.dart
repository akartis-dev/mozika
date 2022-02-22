import 'package:flutter/material.dart';
import 'package:mozika/utils/theme.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  OutlineInputBorder styleBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.white12));

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      decoration: InputDecoration(
          border: styleBorder,
          enabledBorder: styleBorder,
          focusedBorder: styleBorder,
          hoverColor: Colors.white,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white30),
          filled: true,
          fillColor: Colors.white12),
    );
  }
}
