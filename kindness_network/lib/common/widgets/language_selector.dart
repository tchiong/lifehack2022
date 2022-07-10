import 'package:flutter/material.dart';
import 'package:kindness_network/data/users.dart';

void defaultFunc() {}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector(
      {Key? key, required this.userId, this.callback = defaultFunc})
      : super(key: key);
  final int userId;
  final VoidCallback callback;

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
            callback;
          },
          child: const Text("English"),
        ),
        TextButton(
          onPressed: () {
            setUserLanguage(Lang.ms);
            callback;
          },
          child: const Text("Bahasa Melayu"),
        ),
        TextButton(
          onPressed: () {
            setUserLanguage(Lang.ch);
            callback;
          },
          child: const Text("中文"),
        ),
        TextButton(
          onPressed: () {
            setUserLanguage(Lang.ta);
            callback;
          },
          child: const Text("தமிழ்"),
        ),
      ],
    );
  }
}
