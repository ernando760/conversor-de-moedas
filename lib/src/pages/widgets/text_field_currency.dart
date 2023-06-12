// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFieldCurrency extends StatelessWidget {
  const TextFieldCurrency({
    Key? key,
    this.controller,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .1 // 100
      ,
      height: 70,
      decoration: const BoxDecoration(),
      child: TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(hintText: hintText)),
    );
  }
}