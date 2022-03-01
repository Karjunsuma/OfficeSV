import 'package:flutter/material.dart';

class ShowButton extends StatelessWidget {
final String label;

  const ShowButton({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: null, child: Text('Login'));
  }
}
