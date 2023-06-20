import './../models/currency_model.dart';

abstract class CurrencyRepository {
  Future<List<String>> getAllCurrencys();
  Future<List<String>> getCombinationsCurrencys();
  Future<CurrencyModel> convertCurrency(
      {required String code, required String codein, required String value});
}
