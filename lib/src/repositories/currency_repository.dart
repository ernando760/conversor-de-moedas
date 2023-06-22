import './../models/currency_model.dart';

abstract class CurrencyRepository {
  Future<List<CurrencyModel>> getAllCurrencys();
  Future<({CurrencyModel code, CurrencyModel codein})> getCodeAndCodein(
      {required String code, required String codein});
  Future<String> convertCurrency(
      {required String code, required String codein, required String value});
}
