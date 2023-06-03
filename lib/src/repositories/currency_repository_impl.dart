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
      required int value}) async {
    final res = await _dio
        .get('https://economia.awesomeapi.com.br/$code-$codein/$value');

    final res2 = await _dio.get('https://cdn.moeda.info/api/latest.json');

    log(res2.data);

    final data = res.data[0] as Map<String, dynamic>;
    log('$data');
    return CurrentModel.fromMap(data);
  }
}
