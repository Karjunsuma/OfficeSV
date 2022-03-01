import 'package:flutter/material.dart';

import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/widgets/show_text.dart';

class Showform extends StatelessWidget {
  final String label;
  final IconData icondata;
  final bool? sccuText;

  const Showform({
    Key? key,
    required this.label,
    required this.icondata,
    this.sccuText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      height: 40,
      child: TextFormField(obscureText: sccuText ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4),
          prefixIcon: Icon(
            icondata,
            color: MyConstant.dark,
          ),
          label: ShowText(label: label),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyConstant.dark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyConstant.ligh)),
        ),
      ),
    );
  }
}
