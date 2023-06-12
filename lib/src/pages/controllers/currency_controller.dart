import 'dart:developer';

import 'package:flutter/material.dart';

import '../../models/currency_model.dart';
import '../../repositories/currency_repository.dart';

enum CurrencyStatusState {
  initial,
  loading,
  success,
  failure,
}

class CurrencyController extends ChangeNotifier {
  final CurrencyRepository _currencyRepository;
  ValueNotifier<CurrencyStatusState> currencyStatus =
      ValueNotifier<CurrencyStatusState>(CurrencyStatusState.initial);
  CurrentModel? currencyModel;
  String codeCurrent = "USD";
  String codeinCurrent = "BRL";

  TextEditingController codeControllerText = TextEditingController();
  TextEditingController codeinControllerText = TextEditingController();

  final currencys = ["USD", "BRL", "EUR", "TST"];

  CurrencyController(this._currencyRepository);

  Future<void> convertCurrency(
      {required String code,
      required String codein,
      required String value}) async {
    currencyStatus.value = CurrencyStatusState.loading;
    currencyModel = await _currencyRepository.convertCurrency(
        code: code, codein: codein, value: value);
    log('${currencyModel?.toMap()}');
    currencyStatus.value = CurrencyStatusState.success;
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
}
