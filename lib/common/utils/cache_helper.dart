import 'package:flutter_application_5/presentation/splash/application/splash_model.dart';

class CacheHelper {
  static late String? _encKey;
  static late String? _encSeq;
  static late SessionAuth? _sessionAuth;

  /// session
  static void setEncData(String? encKey, String? encSeq) {
    _encKey = encKey;
    _encSeq = encSeq;
  }

  static String getEncKey() {
    return _encKey ?? '';
  }

  static String getEncSeq() {
    return _encSeq ?? '';
  }

  /// session auth
  static void setSessionAuth(SessionAuth? sessionAuthInfo) {
    _sessionAuth = sessionAuthInfo;
  }

  static List<ImagePopupData>? getImagePopup() {
    return _sessionAuth?.imagePopupList;
  }
}