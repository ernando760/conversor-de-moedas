// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurrencyModel {
  final String name;
  final String symbolNative;
  final String code;

  CurrencyModel({
    required this.name,
    required this.symbolNative,
    required this.code,
  });

  CurrencyModel copyWith({
    String? name,
    String? symbolNative,
    String? code,
  }) {
    return CurrencyModel(
      name: name ?? this.name,
      symbolNative: symbolNative ?? this.symbolNative,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'symbolNative': symbolNative,
      'code': code,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      name: map['name'] as String,
      symbolNative: map['symbolNative'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyModel.fromJson(String source) =>
      CurrencyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CurrencyModel(name: $name, symbolNative: $symbolNative, code: $code)';

  @override
  bool operator ==(covariant CurrencyModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.symbolNative == symbolNative &&
        other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ symbolNative.hashCode ^ code.hashCode;
}
