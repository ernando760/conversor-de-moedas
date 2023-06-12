// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

class CurrencyDropDownButton extends StatelessWidget {
  const CurrencyDropDownButton({
    Key? key,
    required this.codeCurrent,
    required this.currencys,
    required this.onChanged,
  }) : super(key: key);
  final String codeCurrent;
  final List<String> currencys;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: codeCurrent,
        items: currencys
            .map(
              (currency) => DropdownMenuItem(
                value: currency,
                child: Text(currency),
                onTap: () {
                  log(currency);
                },
              ),
            )
            .toList(),
        onChanged: onChanged);
  }
}
