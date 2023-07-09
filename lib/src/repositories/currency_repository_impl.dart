import 'dart:developer';
import 'package:dio/dio.dart';

import '../../main.dart';
import '../../src/models/currency_model.dart';
import '../../src/repositories/currency_repository.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final Dio _dio = Dio();
  List<CurrencyModel> _currencies = [];

  CurrencyRepositoryImpl();

  @override
  Future<List<CurrencyModel>> getAllCurrencys() async {
    try {
      final res = await _dio.get(
        "${enviroment.urlBase}/currencies",
      );
      if (res.statusCode == 404) {
        return [];
      }
      final dataMap = res.data["data"] as Map<String, dynamic>;

      _currencies = dataMap.keys
          .map(
            (key) => CurrencyModel.fromMap(dataMap[key]),
          )
          .toList();
      log("$_currencies");
      return _currencies;
    } on DioError catch (e, s) {
      log("Error ao obter as moedas: ${e.message}", error: e, stackTrace: s);
      return [];
    } on DioMixin catch (e, s) {
      log("Error ao obter as moedas ", error: e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<({CurrencyModel? currencyBase, CurrencyModel? currencyTarget})>
      getCurrencyBaseAndCurrencyTarget(
          {required String base, required String target}) async {
    if (_currencies.isNotEmpty) {
      final currencyBase =
          _currencies.firstWhere((currency) => currency.code == base);
      final currencyTarget =
          _currencies.firstWhere((currency) => currency.code == target);
      log("get Currency => base: ${currencyBase.code} / target: ${currencyTarget.code}");
      return (currencyBase: currencyBase, currencyTarget: currencyTarget);
    }
    return (currencyBase: null, currencyTarget: null);
  }

  @override
  Future<String> convertCurrency(
      {required String base,
      required String target,
      required String value}) async {
    try {
      final res = await _dio.get(
        "${enviroment.urlBase}/convert",
        queryParameters: {"base": base, "target": target, "base_amount": value},
      );

      if (res.statusCode == 404 || value.isEmpty) {
        return "0";
      }

      final double amount = res.data["data"]["converted_amount"];
      // final amountToString =
      //     amount.toStringAsExponential(2).compareTo("0.00") == 0
      //         ? amount.toStringAsFixed(2)
      //         : amount.toString();
      // log("amount: $amountToString");
      return amount.toString();
    } on DioError catch (e, s) {
      log("ERROR a conveter as moedas", error: e, stackTrace: s);
      return "0";
    }
  }

  @override
  Future<CurrencyModel?> liveCurrency({required String base}) async {
    final result = await _dio
        .get("${enviroment.urlBase}/live", queryParameters: {"base": base});
    if (result.statusCode == 404) {
      return null;
    }
    final data = result.data["data"] as Map<String, dynamic>;
    final currency = _currencies
        .firstWhere((currency) => currency.code == base)
        .copyWith(exchangeRates: data["exchange_rates"]);
    return currency;
  }
}
