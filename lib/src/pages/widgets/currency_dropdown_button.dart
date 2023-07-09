// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:conversor_de_moedas/src/models/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyDropDownButton extends StatelessWidget {
  const CurrencyDropDownButton({
    Key? key,
    required this.codeCurrent,
    required this.currencys,
    required this.onChanged,
  }) : super(key: key);
  final String codeCurrent;
  final List<CurrencyModel> currencys;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: MediaQuery.sizeOf(context).width * 0.5,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFB0B0B0)),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              value: codeCurrent,
              alignment: Alignment.center,
              menuMaxHeight: MediaQuery.sizeOf(context).height * 0.3,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF292929), weight: 5),
              style: const TextStyle(
                  color: Color(0xFF292929), fontWeight: FontWeight.w600),
              items: currencys.map((currency) {
                return DropdownMenuItem(
                    alignment: Alignment.center,
                    value: currency.code,
                    child: Text(currency.code));
              }).toList(),
              onChanged: onChanged)),
    );
  }
}

//  DropdownButton<String>(
//         value: codeCurrent,
//         iconSize: 20.0,
//         menuMaxHeight: MediaQuery.sizeOf(context).height * 0.3,
//         borderRadius: BorderRadius.circular(10),
//         items: currencys
//             .map(
//               (currency) => DropdownMenuItem(
//                 value: currency.code,
//                 child: Text(currency.code),
//               ),
//             )
//             .toList(),
//         onChanged: onChanged);

 