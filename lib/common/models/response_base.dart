import 'package:json_annotation/json_annotation.dart';

part 'response_base.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class RootFinance<T> {
  @JsonKey(name: 'Finance')
  final ResponseBase<T>? finance;

  RootFinance({this.finance});

  factory RootFinance.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$RootFinanceFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$RootFinanceToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class ResponseBase<T> {
  @JsonKey(name: 'Header')
  final ResponseHeader header;

  @JsonKey(name: 'Body')
  final T? body;

  ResponseBase({required this.header, this.body});

  bool get isSuccess => header.code == "10000";

  factory ResponseBase.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ResponseBaseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ResponseBaseToJson(this, toJsonT);
}

@JsonSerializable()
class ResponseHeader {
  @JsonKey(name: 'Code')
  final String code;
  @JsonKey(name: 'Message')
  final String message;

  ResponseHeader({required this.code, required this.message});

  factory ResponseHeader.fromJson(Map<String, dynamic> json) =>
      _$ResponseHeaderFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseHeaderToJson(this);
}

// @JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
// class ResponseBody<T> {
//   @JsonKey(name: 'Detail')
//   final T? detail;

//   @JsonKey(name: 'SvrTime')
//   final String? svrTime;

//   ResponseBody({this.detail, this.svrTime});

//   factory ResponseBody.fromJson(
//     Map<String, dynamic> json,
//     T Function(Object? json) fromJsonT,
//   ) =>
//       _$ResponseBodyFromJson(json, fromJsonT);

//   /// ✅ null-safe 처리
//   Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => {
//         'Detail': detail == null ? null : toJsonT(detail as T),
//         'SvrTime': svrTime,
//       };
// }