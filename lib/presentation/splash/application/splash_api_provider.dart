import 'package:dio/dio.dart';
import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/common/provider/dio_provider.dart';
import 'package:flutter_application_5/common/utils/cache_helper.dart';
import 'package:flutter_application_5/common/utils/crypto_helper.dart';
import 'package:flutter_application_5/common/utils/device_info_helper.dart';
import 'package:flutter_application_5/common/utils/shared_preferences_helper.dart';
import 'package:flutter_application_5/presentation/splash/application/splash_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final splashApiProvider = Provider<SplashApiProvider>((ref) {
  final dio = ref.read(dioProvider);
  return SplashApiProvider(dio);
});

class SplashApiProvider {
  final Dio _dio;

  SplashApiProvider(this._dio);

  Future<Response<RootFinance<FinanceSessionDetail>>> getSession() async {
  final uuid = Uuid().v4().replaceAll(RegExp('-'), '');
  final p02 = CryptHelper.encryptByAes(uuid, 'P01');

  final response = await _dio.get('/G001/03_01_01.do', queryParameters: {
    'P01': uuid,
    'P02': p02,
  });

  final parsed = RootFinance<FinanceSessionDetail>.fromJson(
    response.data,
    (json) => FinanceSessionDetail.fromJson(json as Map<String, dynamic>),
  );

  return Response(
      data: parsed,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }

  Future<Response<RootFinance<FinanceSessionAuthDetail>>> getSessionAuth() async {
    final encKey = CacheHelper.getEncKey();

    final p01 = CacheHelper.getEncSeq();
    final String? userPhone = SharedPreferencesHelper.getData(key: SharedPreferencesHelper.key_phone_number);
    final p02 = CryptHelper.encryptByAes(encKey, userPhone ?? "");
    final p03 = CryptHelper.encryptByAes(encKey, "IOS");
    final String? memberId = SharedPreferencesHelper.getData(key: SharedPreferencesHelper.key_member_id);
    final p04 = CryptHelper.encryptByAes(encKey, memberId ?? "");
    final String? lastJoin = SharedPreferencesHelper.getData(key: SharedPreferencesHelper.key_user_check);
    final p05 = CryptHelper.encryptByAes(encKey, lastJoin ?? "");
    final deviceInfo = await DeviceInfoHelper.getDeviceInfo();
    final p07 = CryptHelper.encryptByAes(encKey, deviceInfo[DeviceInfoHelper.device_info_os_version]);
    final packageInfo = await DeviceInfoHelper.getPackageInfo();
    final p08 = CryptHelper.encryptByAes(encKey, packageInfo[DeviceInfoHelper.package_info_version]);
    final p09 = CryptHelper.encryptByAes(encKey, Uuid().v4());
    final p10 = CryptHelper.encryptByAes(encKey, deviceInfo[DeviceInfoHelper.device_info_model]);

    final response = await _dio.get('/G001/03_01_02.do', queryParameters: {
    'P01': p01,
    'P02': p02,
    'P03': p03,
    'P04': p04,
    'P05': p05,
    'P07': p07,
    'P08': p08,
    'P09': p09,
    'P10': p10,
  });

  final parsed = RootFinance<FinanceSessionAuthDetail>.fromJson(
    response.data,
    (json) => FinanceSessionAuthDetail.fromJson(json as Map<String, dynamic>),
  );

  return Response(
      data: parsed,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }
}