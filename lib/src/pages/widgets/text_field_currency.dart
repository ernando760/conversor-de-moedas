// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TextFieldCurrency extends StatelessWidget {
  const TextFieldCurrency(
      {Key? key,
      this.controller,
      this.onChanged,
      required this.hintText,
      this.symbol,
      this.readOnly = false})
      : super(key: key);
  final TextEditingController? controller;
  final String? symbol;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .5,
      height: MediaQuery.sizeOf(context).height * .1,
      decoration: const BoxDecoration(),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              alignLabelWithHint: true,
              hintText: hintText,
              prefixIcon: symbol != null
                  ? Container(
                      // color: Colors.red,
                      width: 20,
                      transformAlignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          symbol!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF292929)),
                        ),
                      ),
                    )
                  : null),
          keyboardType: TextInputType.number,
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly,
        ),
      ),
    );
  }
}
