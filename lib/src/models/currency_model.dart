// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurrencyModel {
  final String code;
  final String codein;
  final String value;

  CurrencyModel({
    required this.code,
    required this.codein,
    required this.value,
  });

  CurrencyModel copyWith({
    String? code,
    String? codein,
    String? value,
  }) {
    return CurrencyModel(
      code: code ?? this.code,
      codein: codein ?? this.codein,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'codeIn': codein,
      'value': value,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      code: map['code'] as String,
      codein: map['codein'] as String,
      value: map['bid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyModel.fromJson(String source) =>
      CurrencyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CurrentModel(code: $code, codein: $codein, value: $value)';

  @override
  bool operator ==(covariant CurrencyModel other) {
    if (identical(this, other)) return true;

    return other.code == code && other.codein == codein && other.value == value;
  }

  @override
  int get hashCode => code.hashCode ^ codein.hashCode ^ value.hashCode;
}
