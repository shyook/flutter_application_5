import 'package:json_annotation/json_annotation.dart';

part 'accountbook_model.g.dart';

/// 1️⃣ Server Time API
@JsonSerializable()
class ServerTimeDetail {
  @JsonKey(name: 'Detail')
  final ServerTime? detail;
  
  ServerTimeDetail({this.detail});

  factory ServerTimeDetail.fromJson(Map<String, dynamic> json) =>
      _$ServerTimeDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ServerTimeDetailToJson(this);
}

@JsonSerializable()
class ServerTime {
  @JsonKey(name: 'SvrTime')
  final String? svrTime;

  ServerTime({this.svrTime});

  factory ServerTime.fromJson(Map<String, dynamic> json) =>
      _$ServerTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ServerTimeToJson(this);
}

/// 3️⃣ Action API
@JsonSerializable()
class FinanceActionDetail {
  @JsonKey(name: 'Result')
  final String? result;

  FinanceActionDetail({this.result});

  factory FinanceActionDetail.fromJson(Map<String, dynamic> json) =>
      _$FinanceActionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$FinanceActionDetailToJson(this);
}