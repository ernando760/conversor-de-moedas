import 'dart:async';

import 'package:money_formatter/money_formatter.dart';

import '../../models/currency_model.dart';
import 'package:flutter/material.dart';

import 'currency_dropdown_button.dart';
import 'text_field_currency.dart';

class BoxCurrencyCustom extends StatelessWidget {
  BoxCurrencyCustom(
      {super.key,
      this.currencyControllerText,
      this.label,
      this.currencyCode,
      this.symbol,
      this.currencies,
      this.onchangeDropBox,
      this.onchangeTextField,
      this.isCurrencyBase = false,
      this.amount = "0"});
  final TextEditingController? currencyControllerText;
  final String? label;
  final String? currencyCode;
  final String? symbol;
  final List<CurrencyModel>? currencies;
  final ValueChanged<String?>? onchangeDropBox;
  final ValueChanged<String>? onchangeTextField;
  final deboucer = Debouncer(milliseconds: 300);
  final bool? isCurrencyBase;
  final String? amount;

  @override
  Widget build(BuildContext context) {
    MoneyFormatter mf = MoneyFormatter(
        amount: double.parse(amount ?? "0"),
        settings: MoneyFormatterSettings(
            symbol: symbol,
            thousandSeparator: ',',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: amount?.length,
            compactFormatType: CompactFormatType.long));
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20),
      height: MediaQuery.sizeOf(context).height * 0.1,
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CurrencyDropDownButton(
              codeCurrent: currencyCode ?? "",
              currencys: currencies ?? [],
              onChanged: (value) {
                if (onchangeDropBox != null) {
                  deboucer.run(() {
                    onchangeDropBox!(value);
                  });
                }
              }),
          const SizedBox(
            width: 50,
          ),
          isCurrencyBase == true
              ? TextFieldCurrency(
                  hintText: label ?? "",
                  symbol: symbol,
                  controller: currencyControllerText,
                  onChanged: (value) {
                    if (onchangeTextField != null) {
                      deboucer.run(() {
                        onchangeTextField!(value);
                      });
                    }
                  },
                )
              : TextFieldCurrency(
                  readOnly: true, hintText: mf.output.symbolOnLeft)
        ],
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
