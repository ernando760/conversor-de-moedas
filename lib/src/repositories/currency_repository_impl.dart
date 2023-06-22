import 'dart:developer';
import 'package:dio/dio.dart';

import '../../main.dart';
import '../../src/models/currency_model.dart';
import '../../src/repositories/currency_repository.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final Dio _dio = Dio();
  List<CurrencyModel> _currencies = [];

  @override
  Future<List<CurrencyModel>> getAllCurrencys() async {
    final res = await _dio.get(
      "${enviroment.urlBase}currencies",
      queryParameters: {
        "apikey": enviroment.apiKey,
      },
    );

    final currencysMap = (res.data["data"] as Map<String, dynamic>);
    log("$currencysMap");
    _currencies = currencysMap.keys
        .map((keys) => CurrencyModel.fromMap({
              "name": currencysMap[keys]["name"],
              "symbolNative": currencysMap[keys]["symbol_native"],
              "code": currencysMap[keys]["code"]
            }))
        .toList();
    log("$_currencies", name: "currencys");
    return _currencies;
  }

  @override
  Future<({CurrencyModel code, CurrencyModel codein})> getCodeAndCodein(
      {required String code, required String codein}) async {
    final symbolNativeCode =
        _currencies.firstWhere((currency) => currency.code == code);
    final symbolNativeCodein =
        _currencies.firstWhere((currency) => currency.code == codein);
    return (code: symbolNativeCode, codein: symbolNativeCodein);
  }

  @override
  Future<String> convertCurrency(
      {required String code,
      required String codein,
      required String value}) async {
    try {
      if (value.isEmpty) {
        return "0";
      }
      final res = await _dio.get(
        "${enviroment.urlBase}latest",
        queryParameters: {
          "apikey": enviroment.apiKey,
          "base_currency": code,
          "currencies": codein,
        },
      );
      final double amount = res.data["data"][codein] * double.parse(value);
      log("amount: $amount");
      return amount.toStringAsFixed(2);
    } on DioError catch (e, s) {
      log("ERROR a conveter as moedas", error: e, stackTrace: s);
      return "0";
    }
  }
}
