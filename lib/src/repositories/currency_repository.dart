import './../models/currency_model.dart';

abstract class CurrencyRepository {
  Future<List<CurrencyModel>> getAllCurrencys();
  Future<({CurrencyModel? currencyBase, CurrencyModel? currencyTarget})>
      getCurrencyBaseAndCurrencyTarget(
          {required String base, required String target});
  Future<String> convertCurrency(
      {required String base, required String target, required String value});
  Future<CurrencyModel?> liveCurrency({required String base});
}
