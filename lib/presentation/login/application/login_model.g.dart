// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinStatusDetail _$PinStatusDetailFromJson(Map<String, dynamic> json) =>
    PinStatusDetail(
      detail: json['Detail'] == null
          ? null
          : PinStatus.fromJson(json['Detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PinStatusDetailToJson(PinStatusDetail instance) =>
    <String, dynamic>{'Detail': instance.detail};

PinStatus _$PinStatusFromJson(Map<String, dynamic> json) => PinStatus(
  validYn: json['ValidYn'] as String?,
  failCnt: json['FailCnt'] as String?,
  pinNumYn: json['PinNumYn'] as String?,
);

Map<String, dynamic> _$PinStatusToJson(PinStatus instance) => <String, dynamic>{
  'ValidYn': instance.validYn,
  'FailCnt': instance.failCnt,
  'PinNumYn': instance.pinNumYn,
};

PinVerifyDetail _$PinVerifyDetailFromJson(Map<String, dynamic> json) =>
    PinVerifyDetail(
      detail: json['Detail'] == null
          ? null
          : PinVerify.fromJson(json['Detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PinVerifyDetailToJson(PinVerifyDetail instance) =>
    <String, dynamic>{'Detail': instance.detail};

PinVerify _$PinVerifyFromJson(Map<String, dynamic> json) => PinVerify(
  authResultCode: json['AuthResultCode'] as String?,
  authResultCode2: json['AuthResultCode2'] as String?,
  failCnt: json['FailCnt'] as String?,
);

Map<String, dynamic> _$PinVerifyToJson(PinVerify instance) => <String, dynamic>{
  'AuthResultCode': instance.authResultCode,
  'AuthResultCode2': instance.authResultCode2,
  'FailCnt': instance.failCnt,
};

PinRegisterDetail _$PinRegisterDetailFromJson(Map<String, dynamic> json) =>
    PinRegisterDetail(
      detail: json['Detail'] == null
          ? null
          : PinRegister.fromJson(json['Detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PinRegisterDetailToJson(PinRegisterDetail instance) =>
    <String, dynamic>{'Detail': instance.detail};

PinRegister _$PinRegisterFromJson(Map<String, dynamic> json) => PinRegister(
  authResultCode: json['AuthResultCode'] as String?,
  failMessage: json['FailMessage'] as String?,
  failCnt: json['FailCnt'] as String?,
);

Map<String, dynamic> _$PinRegisterToJson(PinRegister instance) =>
    <String, dynamic>{
      'AuthResultCode': instance.authResultCode,
      'FailMessage': instance.failMessage,
      'FailCnt': instance.failCnt,
    };
