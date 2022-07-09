import 'package:flutter/material.dart';
import 'package:kindness_network/data/users.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key, required this.userId}) : super(key: key);
  final int userId;

  setUserLanguage(Lang language) {
    User.setUserIdLang(language, userId);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            setUserLanguage(Lang.en);
          },
          child: const Text("English"),
        ),
        TextButton(
          onPressed: () {
            setUserLanguage(Lang.ms);
          },
          child: const Text("Bahasa Melayu"),
        ),
        TextButton(
          onPressed: () {
            setUserLanguage(Lang.ch);
          },
          child: const Text("中文"),
        ),
        TextButton(
          onPressed: () {
            setUserLanguage(Lang.ta);
          },
          child: const Text("தமிழ்"),
        ),
      ],
    );
  }
}
