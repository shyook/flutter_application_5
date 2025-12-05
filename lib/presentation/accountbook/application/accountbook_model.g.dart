// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountbook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBookReportDetail _$AccountBookReportDetailFromJson(
  Map<String, dynamic> json,
) => AccountBookReportDetail(
  detail: json['Detail'] == null
      ? null
      : ReportDetail.fromJson(json['Detail'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountBookReportDetailToJson(
  AccountBookReportDetail instance,
) => <String, dynamic>{'Detail': instance.detail};

ReportDetail _$ReportDetailFromJson(Map<String, dynamic> json) =>
    ReportDetail(schSettingYn: json['SchSettingYn'] as String?);

Map<String, dynamic> _$ReportDetailToJson(ReportDetail instance) =>
    <String, dynamic>{'SchSettingYn': instance.schSettingYn};

AccountBookIncomeDetail _$AccountBookIncomeDetailFromJson(
  Map<String, dynamic> json,
) => AccountBookIncomeDetail(
  detail: json['Detail'] == null
      ? null
      : IncomeDetail.fromJson(json['Detail'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountBookIncomeDetailToJson(
  AccountBookIncomeDetail instance,
) => <String, dynamic>{'Detail': instance.detail};

IncomeDetail _$IncomeDetailFromJson(Map<String, dynamic> json) => IncomeDetail(
  searchYear: json['SearchYear'] as String?,
  incomeAmt: json['IncomeAmt'] as String?,
  incomePlanAmt: json['IncomePlanAmt'] as String?,
  accountBaseDay: json['accountBaseDay'] as String?,
  beginYyyymmdd: json['beginYyyymmdd'] as String?,
  endYyyymmdd: json['endYyyymmdd'] as String?,
);

Map<String, dynamic> _$IncomeDetailToJson(IncomeDetail instance) =>
    <String, dynamic>{
      'SearchYear': instance.searchYear,
      'IncomeAmt': instance.incomeAmt,
      'IncomePlanAmt': instance.incomePlanAmt,
      'accountBaseDay': instance.accountBaseDay,
      'beginYyyymmdd': instance.beginYyyymmdd,
      'endYyyymmdd': instance.endYyyymmdd,
    };

ServerTimeDetail _$ServerTimeDetailFromJson(Map<String, dynamic> json) =>
    ServerTimeDetail(
      detail: json['Detail'] == null
          ? null
          : ServerTime.fromJson(json['Detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerTimeDetailToJson(ServerTimeDetail instance) =>
    <String, dynamic>{'Detail': instance.detail};

ServerTime _$ServerTimeFromJson(Map<String, dynamic> json) =>
    ServerTime(svrTime: json['SvrTime'] as String?);

Map<String, dynamic> _$ServerTimeToJson(ServerTime instance) =>
    <String, dynamic>{'SvrTime': instance.svrTime};

FinanceActionDetail _$FinanceActionDetailFromJson(Map<String, dynamic> json) =>
    FinanceActionDetail(result: json['Result'] as String?);

Map<String, dynamic> _$FinanceActionDetailToJson(
  FinanceActionDetail instance,
) => <String, dynamic>{'Result': instance.result};
