import 'dart:developer';

import 'package:conversor_de_moedas/src/models/currency_model.dart';
import 'package:conversor_de_moedas/src/repositories/currency_repository.dart';
import 'package:dio/dio.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final Dio _dio = Dio();

  @override
  Future<CurrentModel> convertCurrency(
      {required String code,
      required String codein,
      required String value}) async {
    log(value);

    if (value != "0" || value.isNotEmpty) {
      final res = await _dio.get(
          'https://api.invertexto.com/v1/currency/${code}_$codein?token=3745|78VYtk3vhWjclnPZ4gTSSfrLnyBv9Uc0');
      final convertValue = double.parse(value);
      log("convert value: $convertValue");
      var price = convertValue * res.data['${code}_$codein']["price"];

      log("res: ${res.data}");
      final data = {
        "code": code,
        "codein": codein,
        "bid": price.toStringAsFixed(2).toString(),
      };

      return CurrentModel.fromMap(data);
    }

    return CurrentModel.fromMap({
      "code": code,
      "codein": codein,
      "bid": "0",
    });
  }
}
