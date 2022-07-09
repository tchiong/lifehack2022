import 'package:flutter/material.dart';
import 'package:kindness_network/data/users.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key, required this.userId}) : super(key: key);
  final int userId;

  setUserLanguage(Lang language) {}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text("English"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Bahasa Melayu"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("中文"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("தமிழ்"),
        ),
      ],
    );
  }
}
