// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String code;
  final String message;
  final String plugin;

  CustomError({
    this.code = '',
    this.message = '',
    this.plugin = '',
  });

  @override
  List<Object> get props => [code, message, plugin];

  @override
  String toString() => 'CustomError(code: $code, message: $message, plugin: $plugin)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'plugin': plugin,
    };
  }

  factory CustomError.fromMap(Map<String, dynamic> map) {
    return CustomError(
      code: map['code'] as String,
      message: map['message'] as String,
      plugin: map['plugin'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomError.fromJson(String source) =>
      CustomError.fromMap(json.decode(source) as Map<String, dynamic>);
}
