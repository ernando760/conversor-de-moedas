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
  CurrencyStatusState currencyStatus = CurrencyStatusState.initial;
  CurrentModel? currentModel;

  CurrencyController(this._currencyRepository);
  Future<void> convertCurrency(
      {required String code,
      required String codein,
      required int value}) async {
    currencyStatus = CurrencyStatusState.loading;
    // currentModel = await _currencyRepository.convertCurrency(
    //     code: code, codein: codein, value: value);
    final res = await _currencyRepository.convertCurrency(
        code: code, codein: codein, value: value);
    log('${res.toMap()}');
    currencyStatus = CurrencyStatusState.success;
    log('${currentModel?.toMap()}');
    notifyListeners();
  }
}
