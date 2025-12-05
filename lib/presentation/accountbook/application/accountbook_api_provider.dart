import 'package:dio/dio.dart';
import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/common/provider/dio_provider.dart';
import 'package:flutter_application_5/common/utils/cache_helper.dart';
import 'package:flutter_application_5/common/utils/crypto_helper.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountbookApiProvider = Provider<AccountbookApiProvider>((ref) {
  final dio = ref.read(dioProvider);
  return AccountbookApiProvider(dio);
});

class AccountbookApiProvider {
  final Dio _dio;

  AccountbookApiProvider(this._dio);

  Future<Response<RootFinance<AccountBookReportDetail>>> fetchReport() async {
    final p01 = CacheHelper.getEncSeq();
    final response = await _dio.get('/W001/03_04_01.do', queryParameters: {
      'P01': p01,
    });

    final parsed = RootFinance<AccountBookReportDetail>.fromJson(
      response.data,
      (json) => AccountBookReportDetail.fromJson(json as Map<String, dynamic>),
    );

    return Response(
      data: parsed,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }

  Future<Response<RootFinance<AccountBookIncomeDetail>>> fetchTotalIncome(String yyyyMM) async {
    final encKey = CacheHelper.getEncKey();

    final p01 = CacheHelper.getEncSeq();
    final p02 = CryptHelper.encryptByAes(encKey, yyyyMM);
    final response = await _dio.get('/W001/03_04_02.do', queryParameters: {
      'P01': p01,
      'P02': p02,
    });

    final parsed = RootFinance<AccountBookIncomeDetail>.fromJson(
      response.data,
      (json) => AccountBookIncomeDetail.fromJson(json as Map<String, dynamic>),
    );

    return Response(
      data: parsed,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }

  Future<Response<RootFinance<ServerTimeDetail>>> getServerTime() async {
  final p01 = CacheHelper.getEncSeq();

  final response = await _dio.get('/G001/03_01_04.do', queryParameters: {
    'P01': p01,
  });

  final parsed = RootFinance<ServerTimeDetail>.fromJson(
    response.data,
    (json) => ServerTimeDetail.fromJson(json as Map<String, dynamic>),
  );

  return Response(
    data: parsed,
    requestOptions: response.requestOptions,
    statusCode: response.statusCode,
    headers: response.headers,
  );
}

  // Future<RootFinance<FinanceSessionDetail>> getSession() async {
  //   try {
  //     // final response = await _dio.get('/session');
  //     // return response;

  //     final uuid = Uuid().v4().replaceAll(RegExp('-'), '');
  //     final p02 = CryptHelper.encryptByAes(uuid, 'P01');
  //     final response = await _dio.get('/G001/03_01_01.do?P01=$uuid&P02=$p02');

  //     return response.data; // <-- 이미 RootFinance<T>

  //   } catch (e) {
  //     throw Exception('Failed to session');
  //   }
  // }

  Future<Response> getAccountbook(String yyyyMM) async {
    try {
      final response = await _dio.get('/articles/$yyyyMM');
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<Response> postAccountbook(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/articles', data: data);
      return response;
    } catch (e) {
      throw Exception('Failed to post data');
    }
  }
}
