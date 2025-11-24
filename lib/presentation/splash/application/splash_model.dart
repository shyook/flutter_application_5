import 'package:json_annotation/json_annotation.dart';

part 'splash_model.g.dart';

/// 1️⃣ Session API
@JsonSerializable()
class FinanceSessionDetail {
  @JsonKey(name: 'Detail')
  final Session? detail;
  
  FinanceSessionDetail({this.detail});

  factory FinanceSessionDetail.fromJson(Map<String, dynamic> json) =>
      _$FinanceSessionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$FinanceSessionDetailToJson(this);
}

@JsonSerializable()
class Session {
  @JsonKey(name: 'EncSeq')
  final String? encSeq;
  @JsonKey(name: 'EncKey')
  final String? encKey;

  Session({this.encSeq, this.encKey});

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

/// 2️⃣ SessionAuth API
@JsonSerializable()
class FinanceSessionAuthDetail {
  @JsonKey(name: 'Detail')
  final SessionAuth? detail;

  FinanceSessionAuthDetail({this.detail});

  factory FinanceSessionAuthDetail.fromJson(Map<String, dynamic> json) =>
      _$FinanceSessionAuthDetailFromJson(json);
  Map<String, dynamic> toJson() => _$FinanceSessionAuthDetailToJson(this);
}

@JsonSerializable()
class SessionAuth {
  @JsonKey(name: 'AppVer') 
  final String? appVer;
  @JsonKey(name: 'AppVerContents')
  final String? appVerContents;
  @JsonKey(name: 'AppVerType')
  final String? appVerType;
  @JsonKey(name: 'AppVerSubject')
  final String? appVerSubject;
  @JsonKey(name: 'AppVerButton1')
  final String? appVerButton1;
  @JsonKey(name: 'AppVerButton2')
  final String? appVerButton2;
  @JsonKey(name: 'ChkMember')
  final String? chkMember;
  @JsonKey(name: 'SvrTime')
  final String? svrTime;
  @JsonKey(name: 'EmergencyNotice')
  final EmergencyNoticeData? emergencyNotice;
  @JsonKey(name: 'PopupNoticeList')
  final List<PopupNoticeData>? popupNoticeList;
  @JsonKey(name: 'AlramPopupList')
  final List<AlarmPopupData>? alramPopupList;
  @JsonKey(name: 'ImagePopupList')
  final List<ImagePopupData>? imagePopupList;
  @JsonKey(name: 'NeedAdAgree')
  final String? needAdAgree;
  @JsonKey(name: 'UserName')
  final String? userName;
  @JsonKey(name: 'WelcomeMsg')
  final String? welcomeMsg;
  @JsonKey(name: 'PinNumYn')
  final String? pinNumYn;
  @JsonKey(name: 'ProfileImgURL')
  final String? profileImgURL;
  @JsonKey(name: 'DormancyYn')
  final String? dormancyYn;
  @JsonKey(name: 'ConnectionInvitedYn')
  final String? connectionInvitedYn;
  @JsonKey(name: 'AdultYn')
  final String? adultYn;
  // @JsonKey(name: 'SubMenuList')
  // final String? subMenuList;
  @JsonKey(name: 'MydataSyncDate')
  final String? mydataSyncDate;
  @JsonKey(name: 'NewTermsAgreeTargetYn')
  final String? newTermsAgreeTargetYn;
  @JsonKey(name: 'ConnectedOrgGroupInfoList')
  final List<ConnectedOrgGroupInfoListData>? connectedOrgGroupInfoList;
  @JsonKey(name: 'accountBaseDay')
  final String? accountBaseDay;

  SessionAuth({this.appVer, this.appVerContents, this.appVerType, this.appVerSubject, this.appVerButton1, this.appVerButton2, this.chkMember, this.svrTime, this.emergencyNotice, this.popupNoticeList, this.alramPopupList, this.imagePopupList, this.needAdAgree, this.userName, this.welcomeMsg, this.pinNumYn, this.profileImgURL, this.dormancyYn, this.connectionInvitedYn, this.adultYn, this.mydataSyncDate, this.newTermsAgreeTargetYn, this.connectedOrgGroupInfoList, this.accountBaseDay});

  factory SessionAuth.fromJson(Map<String, dynamic> json) =>
      _$SessionAuthFromJson(json);
  Map<String, dynamic> toJson() => _$SessionAuthToJson(this);
}

@JsonSerializable()
class EmergencyNoticeData {
  @JsonKey(name: 'NoticeId')
  final String? noticeId;
  @JsonKey(name: 'NoticeSubject')
  final String? noticeSubject;
  @JsonKey(name: 'NoticeContents')
  final String? noticeContents;
  @JsonKey(name: 'NoticeType')
  final String? noticeType;      // 1103: 앱 사용 가능, 1104: 앱 사용 불가
  @JsonKey(name: 'NoticeStartDate')
  final String? noticeStartDate;
  @JsonKey(name: 'NoticeEndDate')
  final String? noticeEndDate;
  @JsonKey(name: 'NoticeDateDisplayYn')
  final String? noticeDateDisplayYn;    // 긴급공지 시작시간, 종료시간 노출 여부   Y : 노출    N : 미노출

  EmergencyNoticeData({this.noticeId, this.noticeSubject, this.noticeContents, this.noticeType, this.noticeStartDate, this.noticeEndDate, this.noticeDateDisplayYn});

  factory EmergencyNoticeData.fromJson(Map<String, dynamic> json) =>
      _$EmergencyNoticeDataFromJson(json);
  Map<String, dynamic> toJson() => _$EmergencyNoticeDataToJson(this);
}

@JsonSerializable()
class ConnectedOrgGroupInfoListData {
  @JsonKey(name: 'FinanceType')
  final String? financeType;  // 기관 타입
  @JsonKey(name: 'FinanceIndustry')
  final String? financeIndustry;    // 기관 업권 정보
  @JsonKey(name: 'OrgInfoList')
  final List<OrgInfoListData>? orgInfoList;   // 기관 목록

  ConnectedOrgGroupInfoListData({this.financeType, this.financeIndustry, this.orgInfoList});

  factory ConnectedOrgGroupInfoListData.fromJson(Map<String, dynamic> json) =>
      _$ConnectedOrgGroupInfoListDataFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectedOrgGroupInfoListDataToJson(this);
}

@JsonSerializable()
class OrgInfoListData {
  @JsonKey(name: 'FinanceCode')
  final String? financeCode;    // 기관 코드
  @JsonKey(name: 'FinanceName')
  final String? financeName;    // 기관 명
  @JsonKey(name: 'FinanceCiImgUrl')
  final String? financeCiImgUrl;    // 기관별 CI 이미지 URL
  @JsonKey(name: 'FinanceScope')
  final String? financeScope;   // 기관 구분(은행, 보험 등)
  @JsonKey(name: 'FinanceType')
  final String? financeType;    // 기관 타입
  @JsonKey(name: 'FinanceIndustry')
  final String? financeIndustry;    // 기관 업권 정보
  @JsonKey(name: 'AuthMethod')
  final String? authMethod;

  OrgInfoListData({this.financeCode, this.financeName, this.financeCiImgUrl, this.financeScope, this.financeType, this.financeIndustry, this.authMethod});

  factory OrgInfoListData.fromJson(Map<String, dynamic> json) =>
      _$OrgInfoListDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrgInfoListDataToJson(this);
}

@JsonSerializable()
class PopupNoticeData {
  @JsonKey(name: 'PopupId')
  final String? popupId;        // 공지사항 팝업 ID (자세히 보기 선택시 규격 내 3.3.5 호출하여 이동)
  @JsonKey(name: 'PopupTitle')
  final String? popupTitle;
  @JsonKey(name: 'PopupContents')
  final String? popupContents;
  @JsonKey(name: 'TargetCode')
  final String? targetCode;     // 타겟 코드
  @JsonKey(name: 'TargetURL')
  final String? targetURL;  //  외부링크 URL 전달
  @JsonKey(name: 'TargetDetail')
  final String? targetDetail;   // TargetCode중 상세 이동이 필요한 경우
  @JsonKey(name: 'EtcParam')
  final String? etcParam;

  PopupNoticeData({this.popupId, this.popupTitle, this.popupContents, this.targetCode, this.targetURL, this.targetDetail, this.etcParam});

  factory PopupNoticeData.fromJson(Map<String, dynamic> json) =>
      _$PopupNoticeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PopupNoticeDataToJson(this);
}

@JsonSerializable()
class AlarmPopupData {
  @JsonKey(name: 'PopupId')
  final String? popupId;    // 팝업 알림 ID
  @JsonKey(name: 'PopupType')
  final String? popupType;  // STI: 글, 이미지  SIO: 작은 이미지 BIO: 큰 이미지
  @JsonKey(name: 'PopupTitle')
  final String? popupTitle;    //  팝업 제목
  @JsonKey(name: 'PopupContents')
  final String? popupContents;    //  팝업 내용
  @JsonKey(name: 'PopupImgURL')
  final String? popupImgURL;    //  팝업 이미지
  @JsonKey(name: 'PopupMenuDepth')
  final String? popupMenuDepth;     // 어떤 GNB에서 디스플레이 되어야 하는지
  @JsonKey(name: 'TargetButtonName')
  final String? targetButtonName;    //  바로가기 버튼 명
  @JsonKey(name: 'TargetButtonColor')
  final String? targetButtonColor;    //  바로가기 버튼 색상
  @JsonKey(name: 'TargetCode')
  final String? targetCode;    // 타겟 코드 전달
//        1302 : 내카드 코드
//        1303 : 지출관리 화면 코드
//        1304 : 연말정산TIP 화면 코드
//        1307 : 공지사항 화면 코드
//        1310 : 외부링크
  @JsonKey(name: 'TargetURL')
  final String? targetURL;    //  외부링크 URL 전달   TargetCode가 “1310”일 경우 필수
  @JsonKey(name: 'TargetDetail')
  final String? targetDetail;   // TargetCode중 상세 이동이 필요한 경우
  @JsonKey(name: 'EtcParam')
  final String? etcParam;

  AlarmPopupData({this.popupId, this.popupType, this.popupTitle, this.popupContents, this.popupImgURL, this.popupMenuDepth, this.targetButtonName, this.targetButtonColor, this.targetCode, this.targetURL, this.targetDetail, this.etcParam});

  factory AlarmPopupData.fromJson(Map<String, dynamic> json) =>
      _$AlarmPopupDataFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmPopupDataToJson(this);
}

@JsonSerializable()
class ImagePopupData {
  @JsonKey(name: 'PopupId')
  final String? popupId;  // 이미지 팝업 ID
  @JsonKey(name: 'PopupImgURL')
  final String? popupImgURL;  //  팝업 이미지
  @JsonKey(name: 'TargetCode')
  final String? targetCode;  //   타겟 코드 전달
//        1300 : 이동 없음
//        1307 : 공지사항 목록 코드
//        1309 : 이벤트 목록 코드
//        1310 : 외부링크
//        1311 : 공지사항 상세 코드
//        1312 : 이벤트 상세 코드
  
//        - 1307 : 3.6.3 공지사항 목록 호출
//        - 1307 : 3.6.4 이벤트 목록 호출
  @JsonKey(name: 'TargetURL')
  final String? targetURL;  //  외부링크 URL 전달   TargetCode가 “1310”일 경우 필수
  @JsonKey(name: 'TargetDetail')
  final String? targetDetail;
     // TargetCode가 ‘1311’, ‘1312’일 경우 필수
//        - 1311 : 3.6.3 공지사항 목록에 P02파라미터로 값 전달
//        - 1312 : 3.6.5 이벤트 상세에 P04 파라미터로 값 전달
  @JsonKey(name: 'PopupTitle')
  final String? popupTitle;
  @JsonKey(name: 'EtcParam')
  final String? etcParam;

  ImagePopupData({this.popupId, this.popupImgURL, this.targetCode, this.targetURL, this.targetDetail, this.popupTitle, this.etcParam});

  factory ImagePopupData.fromJson(Map<String, dynamic> json) =>
      _$ImagePopupDataFromJson(json);
  Map<String, dynamic> toJson() => _$ImagePopupDataToJson(this);
}