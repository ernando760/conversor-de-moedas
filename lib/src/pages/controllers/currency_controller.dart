import 'package:flutter/material.dart';

import '../../models/currency_model.dart';
import '../../repositories/currency_repository.dart';

class CurrencyController extends ChangeNotifier {
  CurrencyController(this._currencyRepository);

  final CurrencyRepository _currencyRepository;

  String titleConvert = "Dolar/Real";

  String codeCurrent = "USD";
  String codeinCurrent = "BRL";
  ({String symbolCode, String symbolCodein}) symbols = (
    symbolCode: "\$",
    symbolCodein: "R\$",
  );

  String amount = "0";

  TextEditingController codeControllerText = TextEditingController();
  TextEditingController codeinControllerText = TextEditingController();

  List<CurrencyModel> currencies = [];

  Future<void> getAllCurrencys() async {
    currencies = await _currencyRepository.getAllCurrencys();
    final (:code, :codein) = await _currencyRepository.getCodeAndCodein(
        code: codeCurrent, codein: codeinCurrent);
    symbols =
        (symbolCode: code.symbolNative, symbolCodein: codein.symbolNative);
    _titleConvert(code.name, codein.name);
    notifyListeners();
  }

  Future<void> convertCurrency(
      {required String code,
      required String codein,
      required String value}) async {
    if (value != "0" || value.isNotEmpty) {
      amount = (await _currencyRepository.convertCurrency(
              code: code, codein: codein, value: value))
          .toString();
    }
    notifyListeners();
  }

  Future<void> replaceCodeByCodein(String code, String codein) async {
    codeinCurrent = code;
    codeCurrent = codein;
    var (code: newCode, codein: newCodein) =
        await _currencyRepository.getCodeAndCodein(code: codein, codein: code);
    symbols = (
      symbolCode: newCode.symbolNative,
      symbolCodein: newCodein.symbolNative
    );
    _titleConvert(newCode.name, newCodein.name);
    await convertCurrency(
        code: codeCurrent,
        codein: codeinCurrent,
        value: codeControllerText.text);
    codeinControllerText.text = amount;

    notifyListeners();
  }

  Future<void> onChangeCodeDropDown(String? value) async {
    if (value != null) {
      final (newCode, newCodein) = _checkCodeOrCodein(newCode: value);
      var (:code, :codein) = await _currencyRepository.getCodeAndCodein(
          code: value, codein: codeinCurrent);
      symbols =
          (symbolCode: code.symbolNative, symbolCodein: codein.symbolNative);
      _titleConvert(code.name, codein.name);
      await convertCurrency(
          code: newCode, codein: newCodein, value: codeinControllerText.text);
      codeinControllerText.text = amount;
    }
    notifyListeners();
  }

  Future<void> onChangeCodeinDropDown(String? value) async {
    if (value != null) {
      final (newCode, newCodein) = _checkCodeOrCodein(newCodein: value);
      var (:code, :codein) = await _currencyRepository.getCodeAndCodein(
          code: codeCurrent, codein: value);
      symbols =
          (symbolCode: code.symbolNative, symbolCodein: codein.symbolNative);
      _titleConvert(code.name, codein.name);
      await convertCurrency(
          code: newCode, codein: newCodein, value: codeControllerText.text);

      codeinControllerText.text = amount;
    }
    notifyListeners();
  }

  Future<void> onChangeTextFieldCode(String value) async {
    if (value.isNotEmpty) {
      await convertCurrency(
          code: codeCurrent, codein: codeinCurrent, value: value);
      codeinControllerText.text = amount;
    }
    if (value.isEmpty) {
      codeinControllerText.text = "";
    }

    notifyListeners();
  }

  Future<void> onChangeTextFieldCodein(String value) async {
    if (value.isNotEmpty) {
      await convertCurrency(
          code: codeinCurrent, codein: codeCurrent, value: value);
      codeControllerText.text = amount;
    }
    if (value.isEmpty) {
      codeControllerText.text = "";
    }
    notifyListeners();
  }

  (String newCode, String newCodein) _checkCodeOrCodein(
      {String? newCode, String? newCodein}) {
    if (newCodein == null && newCode != null) {
      if (newCode == codeinCurrent) {
        codeinCurrent = codeCurrent;
        codeCurrent = newCode;
        return (codeCurrent, codeinCurrent);
      }
      codeCurrent = newCode;
      return (codeCurrent, codeinCurrent);
    }
    if (newCode == null && newCodein != null) {
      if (newCodein == codeCurrent) {
        codeCurrent = codeinCurrent;
        codeinCurrent = newCodein;
        return (codeCurrent, codeinCurrent);
      }
      codeinCurrent = newCodein;
      return (codeCurrent, codeinCurrent);
    }
    return (codeCurrent, codeinCurrent);
  }

  void _titleConvert(String titleCode, titleCodein) =>
      titleConvert = "$titleCode / $titleCodein";
}
