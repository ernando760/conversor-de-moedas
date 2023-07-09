import 'package:conversor_de_moedas/src/models/currency_model.dart';

abstract class CurrencyState {
  List<CurrencyModel> currencies = [];
  CurrencyModel? currencyBase;
  CurrencyModel? currencyTarget;

  String? amount = "0";
  CurrencyState(
      this.currencies, this.amount, this.currencyBase, this.currencyTarget);
}

class LoadingCurrencyState extends CurrencyState {
  LoadingCurrencyState(
      {CurrencyModel? currencyBase,
      CurrencyModel? currencyTarget,
      List<CurrencyModel>? currencies,
      String? amount})
      : super(currencies ?? [], amount, currencyBase, currencyTarget);
}

class SuccessCurrencyState extends CurrencyState {
  SuccessCurrencyState(
      {required List<CurrencyModel> currencies,
      String? amount,
      CurrencyModel? currencyBase,
      CurrencyModel? currencyTarget})
      : super(currencies, amount, currencyBase, currencyTarget);
}

class FailureCurrencyState extends CurrencyState {
  final String message;
  FailureCurrencyState({required this.message}) : super([], "0", null, null);
}
