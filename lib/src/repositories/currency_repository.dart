import './../models/currency_model.dart';

abstract class CurrencyRepository {
  Future<CurrentModel> convertCurrency(
      {required String code, required String codein, required String value});
}
