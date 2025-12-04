import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

/// pin 상태 체크
@JsonSerializable()
class PinStatusDetail {
  @JsonKey(name: 'Detail')
  final PinStatus? detail;
  
  PinStatusDetail({this.detail});

  factory PinStatusDetail.fromJson(Map<String, dynamic> json) =>
      _$PinStatusDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PinStatusDetailToJson(this);
}

@JsonSerializable()
class PinStatus {
  @JsonKey(name: 'ValidYn')
  final String? validYn;
  @JsonKey(name: 'FailCnt')
  final String? failCnt;
  @JsonKey(name: 'PinNumYn')
  final String? pinNumYn;

  PinStatus({this.validYn, this.failCnt, this.pinNumYn});

  factory PinStatus.fromJson(Map<String, dynamic> json) =>
      _$PinStatusFromJson(json);
  Map<String, dynamic> toJson() => _$PinStatusToJson(this);
}

/// Pin Verify
@JsonSerializable()
class PinVerifyDetail {
@JsonKey(name: 'Detail')
  final PinVerify? detail;
  
  PinVerifyDetail({this.detail});

  factory PinVerifyDetail.fromJson(Map<String, dynamic> json) =>
      _$PinVerifyDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PinVerifyDetailToJson(this);
}

@JsonSerializable()
class PinVerify {
  @JsonKey(name: 'AuthResultCode')
  final String? authResultCode;
  @JsonKey(name: 'AuthResultCode2')
  final String? authResultCode2;
  @JsonKey(name: 'FailCnt')
  final String? failCnt;

  PinVerify({this.authResultCode, this.authResultCode2, this.failCnt});

  factory PinVerify.fromJson(Map<String, dynamic> json) =>
      _$PinVerifyFromJson(json);
  Map<String, dynamic> toJson() => _$PinVerifyToJson(this);
}

/// Pin Register
@JsonSerializable()
class PinRegisterDetail {
@JsonKey(name: 'Detail')
  final PinRegister? detail;
  
  PinRegisterDetail({this.detail});

  factory PinRegisterDetail.fromJson(Map<String, dynamic> json) =>
      _$PinRegisterDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PinRegisterDetailToJson(this);
}

@JsonSerializable()
class PinRegister {
  @JsonKey(name: 'AuthResultCode')
  final String? authResultCode;
  @JsonKey(name: 'FailMessage')
  final String? failMessage;
  @JsonKey(name: 'FailCnt')
  final String? failCnt;

  PinRegister({this.authResultCode, this.failMessage, this.failCnt});

  factory PinRegister.fromJson(Map<String, dynamic> json) =>
      _$PinRegisterFromJson(json);
  Map<String, dynamic> toJson() => _$PinRegisterToJson(this);
}