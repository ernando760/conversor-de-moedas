import 'dart:developer';

import 'package:conversor_de_moedas/src/models/currency_model.dart';
import 'package:conversor_de_moedas/src/repositories/currency_repository.dart';
import 'package:dio/dio.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final Dio _dio = Dio();
  List<String> _currencys = [];
  List<String> _combinationsCurrencys = [];

  @override
  Future<List<String>> getAllCurrencys() async {
    final res = await _dio
        .get("https://economia.awesomeapi.com.br/json/available/uniq");
    final currencysMap = res.data as Map<String, dynamic>;
    _currencys = currencysMap.keys.map((currency) => currency).toList();
    log("$_currencys", name: "currencys");
    return _currencys;
  }

  @override
  Future<List<String>> getCombinationsCurrencys() async {
    final res =
        await _dio.get("https://economia.awesomeapi.com.br/json/available");
    final combinationsCurrencysMap = res.data as Map<String, dynamic>;
    _combinationsCurrencys = combinationsCurrencysMap.keys
        .map((combinationCurrency) => combinationCurrency)
        .toList();
    return _combinationsCurrencys;
  }

  @override
  Future<CurrencyModel> convertCurrency(
      {required String code,
      required String codein,
      required String value}) async {
    try {
      final res = await _dio
          .get("https://economia.awesomeapi.com.br/json/last/$code-$codein");
      if (res.statusCode == 404) {
        return CurrencyModel(code: code, codein: codein, value: value);
      }
      final convertValue = double.parse(value);
      final media = (double.parse(res.data["$code$codein"]["bid"]) +
              double.parse(res.data["$code$codein"]["ask"])) /
          2;
      final price = media * convertValue;

      log("res: ${res.data}");
      return CurrencyModel(
          code: code,
          codein: codein,
          value: price.toStringAsFixed(2).toString());
    } on DioError catch (e, s) {
      log("ERROR a conveter as moedas", error: e, stackTrace: s);
      return CurrencyModel(code: code, codein: codein, value: value);
    }
  }
}
