// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RootFinance<T> _$RootFinanceFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => RootFinance<T>(
  finance: json['Finance'] == null
      ? null
      : ResponseBase<T>.fromJson(
          json['Finance'] as Map<String, dynamic>,
          (value) => fromJsonT(value),
        ),
);

Map<String, dynamic> _$RootFinanceToJson<T>(
  RootFinance<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'Finance': instance.finance?.toJson((value) => toJsonT(value)),
};

ResponseBase<T> _$ResponseBaseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ResponseBase<T>(
  header: ResponseHeader.fromJson(json['Header'] as Map<String, dynamic>),
  body: _$nullableGenericFromJson(json['Body'], fromJsonT),
);

Map<String, dynamic> _$ResponseBaseToJson<T>(
  ResponseBase<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'Header': instance.header.toJson(),
  'Body': _$nullableGenericToJson(instance.body, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

ResponseHeader _$ResponseHeaderFromJson(Map<String, dynamic> json) =>
    ResponseHeader(
      code: json['Code'] as String,
      message: json['Message'] as String,
    );

Map<String, dynamic> _$ResponseHeaderToJson(ResponseHeader instance) =>
    <String, dynamic>{'Code': instance.code, 'Message': instance.message};
