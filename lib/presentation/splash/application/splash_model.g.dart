// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceSessionDetail _$FinanceSessionDetailFromJson(
  Map<String, dynamic> json,
) => FinanceSessionDetail(
  detail: json['Detail'] == null
      ? null
      : Session.fromJson(json['Detail'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FinanceSessionDetailToJson(
  FinanceSessionDetail instance,
) => <String, dynamic>{'Detail': instance.detail};

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
  encSeq: json['EncSeq'] as String?,
  encKey: json['EncKey'] as String?,
);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
  'EncSeq': instance.encSeq,
  'EncKey': instance.encKey,
};

FinanceSessionAuthDetail _$FinanceSessionAuthDetailFromJson(
  Map<String, dynamic> json,
) => FinanceSessionAuthDetail(
  detail: json['Detail'] == null
      ? null
      : SessionAuth.fromJson(json['Detail'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FinanceSessionAuthDetailToJson(
  FinanceSessionAuthDetail instance,
) => <String, dynamic>{'Detail': instance.detail};

SessionAuth _$SessionAuthFromJson(Map<String, dynamic> json) => SessionAuth(
  appVer: json['AppVer'] as String?,
  appVerContents: json['AppVerContents'] as String?,
  appVerType: json['AppVerType'] as String?,
  appVerSubject: json['AppVerSubject'] as String?,
  appVerButton1: json['AppVerButton1'] as String?,
  appVerButton2: json['AppVerButton2'] as String?,
  chkMember: json['ChkMember'] as String?,
  svrTime: json['SvrTime'] as String?,
  emergencyNotice: json['EmergencyNotice'] == null
      ? null
      : EmergencyNoticeData.fromJson(
          json['EmergencyNotice'] as Map<String, dynamic>,
        ),
  popupNoticeList: (json['PopupNoticeList'] as List<dynamic>?)
      ?.map((e) => PopupNoticeData.fromJson(e as Map<String, dynamic>))
      .toList(),
  alramPopupList: (json['AlramPopupList'] as List<dynamic>?)
      ?.map((e) => AlarmPopupData.fromJson(e as Map<String, dynamic>))
      .toList(),
  imagePopupList: (json['ImagePopupList'] as List<dynamic>?)
      ?.map((e) => ImagePopupData.fromJson(e as Map<String, dynamic>))
      .toList(),
  needAdAgree: json['NeedAdAgree'] as String?,
  userName: json['UserName'] as String?,
  welcomeMsg: json['WelcomeMsg'] as String?,
  pinNumYn: json['PinNumYn'] as String?,
  profileImgURL: json['ProfileImgURL'] as String?,
  dormancyYn: json['DormancyYn'] as String?,
  connectionInvitedYn: json['ConnectionInvitedYn'] as String?,
  adultYn: json['AdultYn'] as String?,
  mydataSyncDate: json['MydataSyncDate'] as String?,
  newTermsAgreeTargetYn: json['NewTermsAgreeTargetYn'] as String?,
  connectedOrgGroupInfoList:
      (json['ConnectedOrgGroupInfoList'] as List<dynamic>?)
          ?.map(
            (e) => ConnectedOrgGroupInfoListData.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
  accountBaseDay: json['accountBaseDay'] as String?,
);

Map<String, dynamic> _$SessionAuthToJson(SessionAuth instance) =>
    <String, dynamic>{
      'AppVer': instance.appVer,
      'AppVerContents': instance.appVerContents,
      'AppVerType': instance.appVerType,
      'AppVerSubject': instance.appVerSubject,
      'AppVerButton1': instance.appVerButton1,
      'AppVerButton2': instance.appVerButton2,
      'ChkMember': instance.chkMember,
      'SvrTime': instance.svrTime,
      'EmergencyNotice': instance.emergencyNotice,
      'PopupNoticeList': instance.popupNoticeList,
      'AlramPopupList': instance.alramPopupList,
      'ImagePopupList': instance.imagePopupList,
      'NeedAdAgree': instance.needAdAgree,
      'UserName': instance.userName,
      'WelcomeMsg': instance.welcomeMsg,
      'PinNumYn': instance.pinNumYn,
      'ProfileImgURL': instance.profileImgURL,
      'DormancyYn': instance.dormancyYn,
      'ConnectionInvitedYn': instance.connectionInvitedYn,
      'AdultYn': instance.adultYn,
      'MydataSyncDate': instance.mydataSyncDate,
      'NewTermsAgreeTargetYn': instance.newTermsAgreeTargetYn,
      'ConnectedOrgGroupInfoList': instance.connectedOrgGroupInfoList,
      'accountBaseDay': instance.accountBaseDay,
    };

EmergencyNoticeData _$EmergencyNoticeDataFromJson(Map<String, dynamic> json) =>
    EmergencyNoticeData(
      noticeId: json['NoticeId'] as String?,
      noticeSubject: json['NoticeSubject'] as String?,
      noticeContents: json['NoticeContents'] as String?,
      noticeType: json['NoticeType'] as String?,
      noticeStartDate: json['NoticeStartDate'] as String?,
      noticeEndDate: json['NoticeEndDate'] as String?,
      noticeDateDisplayYn: json['NoticeDateDisplayYn'] as String?,
    );

Map<String, dynamic> _$EmergencyNoticeDataToJson(
  EmergencyNoticeData instance,
) => <String, dynamic>{
  'NoticeId': instance.noticeId,
  'NoticeSubject': instance.noticeSubject,
  'NoticeContents': instance.noticeContents,
  'NoticeType': instance.noticeType,
  'NoticeStartDate': instance.noticeStartDate,
  'NoticeEndDate': instance.noticeEndDate,
  'NoticeDateDisplayYn': instance.noticeDateDisplayYn,
};

ConnectedOrgGroupInfoListData _$ConnectedOrgGroupInfoListDataFromJson(
  Map<String, dynamic> json,
) => ConnectedOrgGroupInfoListData(
  financeType: json['FinanceType'] as String?,
  financeIndustry: json['FinanceIndustry'] as String?,
  orgInfoList: (json['OrgInfoList'] as List<dynamic>?)
      ?.map((e) => OrgInfoListData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ConnectedOrgGroupInfoListDataToJson(
  ConnectedOrgGroupInfoListData instance,
) => <String, dynamic>{
  'FinanceType': instance.financeType,
  'FinanceIndustry': instance.financeIndustry,
  'OrgInfoList': instance.orgInfoList,
};

OrgInfoListData _$OrgInfoListDataFromJson(Map<String, dynamic> json) =>
    OrgInfoListData(
      financeCode: json['FinanceCode'] as String?,
      financeName: json['FinanceName'] as String?,
      financeCiImgUrl: json['FinanceCiImgUrl'] as String?,
      financeScope: json['FinanceScope'] as String?,
      financeType: json['FinanceType'] as String?,
      financeIndustry: json['FinanceIndustry'] as String?,
      authMethod: json['AuthMethod'] as String?,
    );

Map<String, dynamic> _$OrgInfoListDataToJson(OrgInfoListData instance) =>
    <String, dynamic>{
      'FinanceCode': instance.financeCode,
      'FinanceName': instance.financeName,
      'FinanceCiImgUrl': instance.financeCiImgUrl,
      'FinanceScope': instance.financeScope,
      'FinanceType': instance.financeType,
      'FinanceIndustry': instance.financeIndustry,
      'AuthMethod': instance.authMethod,
    };

PopupNoticeData _$PopupNoticeDataFromJson(Map<String, dynamic> json) =>
    PopupNoticeData(
      popupId: json['PopupId'] as String?,
      popupTitle: json['PopupTitle'] as String?,
      popupContents: json['PopupContents'] as String?,
      targetCode: json['TargetCode'] as String?,
      targetURL: json['TargetURL'] as String?,
      targetDetail: json['TargetDetail'] as String?,
      etcParam: json['EtcParam'] as String?,
    );

Map<String, dynamic> _$PopupNoticeDataToJson(PopupNoticeData instance) =>
    <String, dynamic>{
      'PopupId': instance.popupId,
      'PopupTitle': instance.popupTitle,
      'PopupContents': instance.popupContents,
      'TargetCode': instance.targetCode,
      'TargetURL': instance.targetURL,
      'TargetDetail': instance.targetDetail,
      'EtcParam': instance.etcParam,
    };

AlarmPopupData _$AlarmPopupDataFromJson(Map<String, dynamic> json) =>
    AlarmPopupData(
      popupId: json['PopupId'] as String?,
      popupType: json['PopupType'] as String?,
      popupTitle: json['PopupTitle'] as String?,
      popupContents: json['PopupContents'] as String?,
      popupImgURL: json['PopupImgURL'] as String?,
      popupMenuDepth: json['PopupMenuDepth'] as String?,
      targetButtonName: json['TargetButtonName'] as String?,
      targetButtonColor: json['TargetButtonColor'] as String?,
      targetCode: json['TargetCode'] as String?,
      targetURL: json['TargetURL'] as String?,
      targetDetail: json['TargetDetail'] as String?,
      etcParam: json['EtcParam'] as String?,
    );

Map<String, dynamic> _$AlarmPopupDataToJson(AlarmPopupData instance) =>
    <String, dynamic>{
      'PopupId': instance.popupId,
      'PopupType': instance.popupType,
      'PopupTitle': instance.popupTitle,
      'PopupContents': instance.popupContents,
      'PopupImgURL': instance.popupImgURL,
      'PopupMenuDepth': instance.popupMenuDepth,
      'TargetButtonName': instance.targetButtonName,
      'TargetButtonColor': instance.targetButtonColor,
      'TargetCode': instance.targetCode,
      'TargetURL': instance.targetURL,
      'TargetDetail': instance.targetDetail,
      'EtcParam': instance.etcParam,
    };

ImagePopupData _$ImagePopupDataFromJson(Map<String, dynamic> json) =>
    ImagePopupData(
      popupId: json['PopupId'] as String?,
      popupImgURL: json['PopupImgURL'] as String?,
      targetCode: json['TargetCode'] as String?,
      targetURL: json['TargetURL'] as String?,
      targetDetail: json['TargetDetail'] as String?,
      popupTitle: json['PopupTitle'] as String?,
      etcParam: json['EtcParam'] as String?,
    );

Map<String, dynamic> _$ImagePopupDataToJson(ImagePopupData instance) =>
    <String, dynamic>{
      'PopupId': instance.popupId,
      'PopupImgURL': instance.popupImgURL,
      'TargetCode': instance.targetCode,
      'TargetURL': instance.targetURL,
      'TargetDetail': instance.targetDetail,
      'PopupTitle': instance.popupTitle,
      'EtcParam': instance.etcParam,
    };
