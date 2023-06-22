// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TextFieldCurrency extends StatelessWidget {
  const TextFieldCurrency({
    Key? key,
    this.controller,
    required this.onChanged,
    required this.hintText,
    required this.symbol,
  }) : super(key: key);
  final TextEditingController? controller;
  final String symbol;
  final ValueChanged<String> onChanged;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .2 // 100
      ,
      height: 64,
      decoration: const BoxDecoration(),
      child: TextField(
        decoration: InputDecoration(hintText: hintText, icon: Text(symbol)),
        keyboardType: TextInputType.number,
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
