// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CurrencyModel {
  final String name;
  final String? symbol;
  final String code;
  final Map<String, dynamic>? exchangeRates;

  CurrencyModel({
    required this.name,
    this.symbol,
    required this.code,
    this.exchangeRates,
  });

  CurrencyModel copyWith({
    String? name,
    String? symbol,
    String? code,
    Map<String, dynamic>? exchangeRates,
  }) {
    return CurrencyModel(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      code: code ?? this.code,
      exchangeRates: exchangeRates ?? this.exchangeRates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'symbol': symbol,
      'code': code,
      'exchangeRates': exchangeRates,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
        name: map['name'] as String,
        symbol: map['symbol'] != null ? map['symbol'] as String : null,
        code: map['code'] as String,
        exchangeRates: map['exchange_rates'] != null
            ? Map<String, dynamic>.from(
                (map['exchange_rates'] as Map<String, dynamic>),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory CurrencyModel.fromJson(String source) =>
      CurrencyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrencyModel(name: $name, symbol: $symbol, code: $code, exchange_rates: $exchangeRates)';
  }

  @override
  bool operator ==(covariant CurrencyModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.symbol == symbol &&
        other.code == code &&
        mapEquals(other.exchangeRates, exchangeRates);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        symbol.hashCode ^
        code.hashCode ^
        exchangeRates.hashCode;
  }
}
