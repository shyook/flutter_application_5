import 'package:json_annotation/json_annotation.dart';

part 'accountbook_model.g.dart';

/// 1️⃣ 리포트 패널 
@JsonSerializable()
class AccountBookReportDetail {
  @JsonKey(name: 'Detail')
  final ReportDetail? detail;
  
  AccountBookReportDetail({this.detail});

  factory AccountBookReportDetail.fromJson(Map<String, dynamic> json) =>
      _$AccountBookReportDetailFromJson(json);
  Map<String, dynamic> toJson() => _$AccountBookReportDetailToJson(this);
}

@JsonSerializable()
class ReportDetail {
  @JsonKey(name: 'SchSettingYn')
  final String? schSettingYn;

  ReportDetail({this.schSettingYn});

  factory ReportDetail.fromJson(Map<String, dynamic> json) =>
      _$ReportDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ReportDetailToJson(this);
}

/// 1️⃣ 수입 패널 
@JsonSerializable()
class AccountBookIncomeDetail {
  @JsonKey(name: 'Detail')
  final IncomeDetail? detail;
  
  AccountBookIncomeDetail({this.detail});

  factory AccountBookIncomeDetail.fromJson(Map<String, dynamic> json) =>
      _$AccountBookIncomeDetailFromJson(json);
  Map<String, dynamic> toJson() => _$AccountBookIncomeDetailToJson(this);
}

@JsonSerializable()
class IncomeDetail {
  @JsonKey(name: 'SearchYear')
  final String? searchYear;
  @JsonKey(name: 'IncomeAmt')
  final String? incomeAmt;
  @JsonKey(name: 'IncomePlanAmt')
  final String? incomePlanAmt;
  @JsonKey(name: 'accountBaseDay')
  final String? accountBaseDay;
  @JsonKey(name: 'beginYyyymmdd')
  final String? beginYyyymmdd;
  @JsonKey(name: 'endYyyymmdd')
  final String? endYyyymmdd;

  IncomeDetail({this.searchYear, this.incomeAmt, this.incomePlanAmt, this.accountBaseDay, this.beginYyyymmdd, this.endYyyymmdd});

  factory IncomeDetail.fromJson(Map<String, dynamic> json) =>
      _$IncomeDetailFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeDetailToJson(this);
}

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