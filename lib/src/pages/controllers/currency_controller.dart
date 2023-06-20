import 'dart:developer';

import 'package:flutter/material.dart';

import '../../models/currency_model.dart';
import '../../repositories/currency_repository.dart';

enum CurrencyMains {
  usd('USD'),
  eur('EUR');

  final String name;
  const CurrencyMains(this.name);
}

class CurrencyController extends ChangeNotifier {
  CurrencyController(this._currencyRepository);

  final CurrencyRepository _currencyRepository;
  CurrencyModel? currencyModel;
  String codeCurrent = "USD";
  String codeinCurrent = "BRL";
  String usd = CurrencyMains.usd.name;
  String eur = CurrencyMains.eur.name;

  TextEditingController codeControllerText = TextEditingController();
  TextEditingController codeinControllerText = TextEditingController();

  List<String> currencys = [];
  List<String> combinationsCurrencys = [];

  Future<void> getAllCurrencys() async {
    currencys = await _currencyRepository.getAllCurrencys();
    log('$currencys');
    notifyListeners();
  }

  Future<void> convertCurrency(
      {required String code,
      required String codein,
      required String value}) async {
    if (value != "0" || value.isNotEmpty) {
      var (newCode, newCodein) = await _getCombination(code, codein);

      if (newCode.isNotEmpty && newCodein.isNotEmpty) {
        log("$newCode-$newCodein", name: "get combination");
        currencyModel = await _currencyRepository.convertCurrency(
            code: newCode, codein: newCodein, value: value);
        log('deu certo');
      } else {
        (newCode, newCodein) = await _getCombination(code, usd);
        final currencyValueOne = (await _currencyRepository.convertCurrency(
                code: newCode, codein: newCodein, value: value))
            .value;
        final currencyValueTwo = (await _currencyRepository.convertCurrency(
                code: codein, codein: usd, value: value))
            .value;
        currencyModel = await _currencyRepository.convertCurrency(
            code: code,
            codein: codein,
            value: (double.parse(currencyValueOne) /
                    double.parse(currencyValueTwo))
                .toString());
        log("$code-$codein", name: "new code isEmpty");

        // else if (newCode.isEmpty) {
        //   (newCode, newCodein) =
        //       await _getCombination(code, currencysMains.name);
        //   log("$code-$codein", name: "new code in isEmpty");
        //   final currencyValue = (await _currencyRepository.convertCurrency(
        //         code: newCode, codein: newCodein, value: value))
        //     .value;
        // log("$code-$codein", name: "new code and new code not is isEmpty");
        // currencyModel = await _currencyRepository.convertCurrency(
        //     code: newCode, codein: newCodein, value: currencyValue);
        // }
      }
    }
    notifyListeners();
  }

  void changeCodeCurrency(String newCode) async {
    if (newCode == codeinCurrent) {
      codeinCurrent = codeCurrent;
      codeCurrent = newCode;
      await convertCurrency(
          code: codeCurrent,
          codein: codeinCurrent,
          value: codeinControllerText.text);
      if (currencyModel != null) {
        codeControllerText.text = currencyModel!.value;
      }
    } else {
      codeCurrent = newCode;
      await convertCurrency(
          code: codeCurrent,
          codein: codeinCurrent,
          value: codeControllerText.text);
      if (currencyModel != null) {
        codeinControllerText.text = currencyModel!.value;
      }
    }
    notifyListeners();
  }

  void changeCodeinCurrency(String newCodein) async {
    if (newCodein == codeCurrent) {
      codeCurrent = codeinCurrent;
      codeinCurrent = newCodein;
      await convertCurrency(
          code: codeCurrent,
          codein: codeinCurrent,
          value: codeControllerText.text);
      if (currencyModel != null) {
        codeinControllerText.text = currencyModel!.value;
      }
    } else {
      codeinCurrent = newCodein;
      await convertCurrency(
          code: codeCurrent,
          codein: codeinCurrent,
          value: codeinControllerText.text);
      if (currencyModel != null) {
        codeControllerText.text = currencyModel!.value;
      }
    }

    notifyListeners();
  }

  Future<void> replaceCodeByCodein(String code, String codein) async {
    codeinCurrent = code;
    codeCurrent = codein;
    await convertCurrency(
        code: codeCurrent,
        codein: codeinCurrent,
        value: codeControllerText.text);
    if (currencyModel != null) {
      codeinControllerText.text = currencyModel!.value;
    }
    notifyListeners();
  }

  Future<void> onChangeCodeDropDown(String? value) async {
    if (value != null) {
      changeCodeCurrency(value);
    }
    notifyListeners();
  }

  Future<void> onChangeCodeinDropDown(String? value) async {
    if (value != null) {
      changeCodeinCurrency(value);
    }
    notifyListeners();
  }

  Future<void> onChangeTextFieldCode(String value) async {
    if (value.isNotEmpty) {
      await convertCurrency(
          code: codeCurrent, codein: codeinCurrent, value: value);
      if (currencyModel != null) {
        codeinControllerText.text = currencyModel!.value;
      }
    }
    if (value.isEmpty) {
      codeinControllerText.text = "";
      currencyModel = currencyModel?.copyWith(value: "0");
    }

    notifyListeners();
  }

  Future<void> onChangeTextFieldCodein(String value) async {
    if (value.isNotEmpty) {
      await convertCurrency(
          code: codeinCurrent, codein: codeCurrent, value: value);
      if (currencyModel != null) {
        codeControllerText.text = currencyModel!.value;
      }
    }
    if (value.isEmpty) {
      codeControllerText.text = "";
      currencyModel = currencyModel?.copyWith(value: "0");
    }
    log('change codein');
    notifyListeners();
  }

  Future<(String code, String codein)> _getCombination(
      String code, String codein) async {
    final combinations = await _currencyRepository.getCombinationsCurrencys();
    var combination = combinations.firstWhere(
        (element) => element.contains("$code-$codein"),
        orElse: () => "");
    if (combination.isNotEmpty) {
      log(combination, name: "combination");
      final newCode = combination.replaceAll("-", "").substring(0, 3);
      final newCodein = combination.replaceAll("-", "").substring(3, 6);
      return (newCode, newCodein);
    }
    return ("", "");
  }
}
