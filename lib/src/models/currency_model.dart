// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurrentModel {
  final String code;
  final String codein;
  final String value;

  CurrentModel({
    required this.code,
    required this.codein,
    required this.value,
  });

  CurrentModel copyWith({
    String? code,
    String? codein,
    String? value,
  }) {
    return CurrentModel(
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

  factory CurrentModel.fromMap(Map<String, dynamic> map) {
    return CurrentModel(
      code: map['code'] as String,
      codein: map['codein'] as String,
      value: map['bid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentModel.fromJson(String source) =>
      CurrentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CurrentModel(code: $code, codein: $codein, value: $value)';

  @override
  bool operator ==(covariant CurrentModel other) {
    if (identical(this, other)) return true;

    return other.code == code && other.codein == codein && other.value == value;
  }

  @override
  int get hashCode => code.hashCode ^ codein.hashCode ^ value.hashCode;
}
