// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountbook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
