import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [ 
        TextButton(onPressed: (){}, child: const Text("English"),),
        TextButton(onPressed: (){}, child: const Text("Bahasa Melayu"),),
      ],
    );
  }
}