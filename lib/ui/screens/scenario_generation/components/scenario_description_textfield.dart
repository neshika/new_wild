import 'package:flutter/material.dart';

class ScenarioDescriptionTextfield extends StatelessWidget {
  const ScenarioDescriptionTextfield({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
  });

  final String title;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField()
      ],
    );
  }
}
