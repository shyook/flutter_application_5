import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/common/utils/cache_helper.dart';
import 'package:flutter_application_5/common/utils/crypto_helper.dart';
import 'package:flutter_application_5/presentation/login/application/login_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/provider/dio_provider.dart';

final loginApiProvider = Provider<LoginApiProvider>((ref) {
  final dio = ref.read(dioProvider);
  return LoginApiProvider(dio);
});

class LoginApiProvider {
  final Dio _dio;

  LoginApiProvider(this._dio);

  Future<Response<RootFinance<PinStatusDetail>>> checkPinStatus() async {
    final encKey = CacheHelper.getEncKey();
    final p01 = CacheHelper.getEncSeq();
    final p02 = CryptHelper.encryptByAes(encKey, '');

    final response = await _dio.get('/G001/03_01_07.do', queryParameters: {
      'P01': p01,
      'P02': p02,
    });

    final parsed = RootFinance<PinStatusDetail>.fromJson(
      response.data,
      (json) => PinStatusDetail.fromJson(json as Map<String, dynamic>),
    );

    return Response(
      data: parsed,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }

  Future<Response<RootFinance<PinVerifyDetail>>> verifyPin(String pinCode, String wordCode) async {
    final encKey = CacheHelper.getEncKey();

    final p01 = CacheHelper.getEncSeq();
    final code = sha256.convert(utf8.encode(pinCode)).toString();
    final p02 = CryptHelper.encryptByAes(encKey, code);

    final response = await _dio.get('/G001/03_01_08.do', queryParameters: {
      'P01': p01,
      'P02': p02,
      'P03': wordCode,
    });

    final parsed = RootFinance<PinVerifyDetail>.fromJson(
      response.data,
      (json) => PinVerifyDetail.fromJson(json as Map<String, dynamic>),
    );

    return Response(
      data: parsed,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }

  Future<Response<RootFinance<PinRegisterDetail>>> registerPin(String pinCode, String type, String prevPinCode) async {
    final encKey = CacheHelper.getEncKey();

    final p01 = CacheHelper.getEncSeq();
    final code = sha256.convert(utf8.encode(pinCode)).toString();
    final p02 = CryptHelper.encryptByAes(encKey, code);
    final p03 = CryptHelper.encryptByAes(encKey, type);
    final p04 = CryptHelper.encryptByAes(encKey, pinCode);
    var p05 = '';
    if (prevPinCode.isNotEmpty) {
      p05 = CryptHelper.encryptByAes(encKey, prevPinCode);
    }

    final response = await _dio.get('/G001/03_01_09.do', queryParameters: {
      'P01': p01,
      'P02': p02,
      'P03': p03,
      'P04': p04,
      'P05': p05,
    });

    final parsed = RootFinance<PinRegisterDetail>.fromJson(
      response.data,
      (json) => PinRegisterDetail.fromJson(json as Map<String, dynamic>),
    );

    return Response(
      data: parsed,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }
}