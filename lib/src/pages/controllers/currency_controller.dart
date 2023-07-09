// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:conversor_de_moedas/src/states/currency_state.dart';
import 'package:flutter/material.dart';

import '../../models/currency_model.dart';
import '../../repositories/currency_repository.dart';

class CurrencyController extends ValueNotifier<CurrencyState> {
  CurrencyController(this._currencyRepository) : super(LoadingCurrencyState());

  CurrencyState get state => value;
  emit(CurrencyState newValue) => value = newValue;

  final CurrencyRepository _currencyRepository;
  List<CurrencyModel> _currencies = [];

  String _currencyBaseCodeCurrent = "USD";
  String _currencyTargetCodeCurrent = "BRL";

  String _amount = "0";

  TextEditingController currencyBaseControllerText = TextEditingController();

  Future<void> getAllCurrencys() async {
    emit(LoadingCurrencyState());
    _currencies = await _currencyRepository.getAllCurrencys();
    emit(SuccessCurrencyState(
        currencies: _currencies,
        currencyBase:
            CurrencyModel(name: "Dólar Americano", code: "USD", symbol: "\$"),
        currencyTarget: CurrencyModel(
            name: "Real Brasileiro", code: "BRL", symbol: "R\$")));

    if (_currencies.isEmpty) {
      emit(FailureCurrencyState(message: "Error ao obter as moedas"));
      return;
    }
  }

  Future<void> convertCurrency(
      {required String base,
      required String target,
      required String value}) async {
    if (value != "0" || value.isNotEmpty) {
      final (:currencyBase, :currencyTarget) =
          await _getCurrencyBaseAndCurrencyTarget(base: base, target: target);
      if (currencyBase != null && currencyTarget != null) {
        emit(LoadingCurrencyState(
            currencies: _currencies,
            currencyBase: currencyBase,
            currencyTarget: currencyTarget));
        _amount = (await _currencyRepository.convertCurrency(
                base: currencyBase.code,
                target: currencyTarget.code,
                value: value))
            .toString();
        emit(SuccessCurrencyState(
            currencies: _currencies,
            amount: _amount,
            currencyBase: currencyBase,
            currencyTarget: currencyTarget));
        return;
      }

      if (_amount == "0") {
        emit(FailureCurrencyState(message: "ERROR ao conveter a moeda"));
        return;
      }
    }
  }

  Future<void> replaceCurrencyBaseByCurrencyTarget(
      String base, String target) async {
    emit(LoadingCurrencyState());
    final (:currencyBase, :currencyTarget) =
        await _getCurrencyBaseAndCurrencyTarget(base: target, target: base);

    log("base: ${currencyBase?.code} -> target: ${currencyTarget?.code}");

    emit(SuccessCurrencyState(
        currencies: _currencies,
        currencyBase: currencyBase,
        currencyTarget: currencyTarget));
  }

  Future<void> onChangeCurrencyBaseDropDown(String? value) async {
    if (value != null) {
      final (:currencyBase, :currencyTarget) =
          await _getCurrencyBaseAndCurrencyTarget(
              base: value, target: _currencyTargetCodeCurrent);
      log("onChangeCurrencyBaseDropDown => ${currencyTarget?.code}");

      emit(SuccessCurrencyState(
          currencies: _currencies,
          currencyBase: currencyBase,
          currencyTarget: currencyTarget));
    }
  }

  Future<void> onChangeCurrencyTargetDropDown(String? target) async {
    log("$target");
    if (target != null) {
      final (:currencyBase, :currencyTarget) =
          await _getCurrencyBaseAndCurrencyTarget(
              base: _currencyBaseCodeCurrent, target: target);

      log("base: ${currencyBase?.code} -> target: ${currencyTarget?.code}");
      emit(SuccessCurrencyState(
          currencies: _currencies,
          amount: _amount,
          currencyBase: currencyBase,
          currencyTarget: currencyTarget));
    }
  }

  Future<({CurrencyModel? currencyBase, CurrencyModel? currencyTarget})>
      _getCurrencyBaseAndCurrencyTarget(
          {required String base, required String target}) async {
    final (:currencyBase, :currencyTarget) = await _currencyRepository
        .getCurrencyBaseAndCurrencyTarget(base: base, target: target);
    if (currencyBase != null && currencyTarget != null) {
      _currencyBaseCodeCurrent = currencyBase.code;
      _currencyTargetCodeCurrent = currencyTarget.code;
      return (currencyBase: currencyBase, currencyTarget: currencyTarget);
    }
    return (currencyBase: null, currencyTarget: null);
  }
}
