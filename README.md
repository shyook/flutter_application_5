# flutter_application_5

/// api provider class ///
import 'package:dio/dio.dart';
import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/common/provider/dio_provider.dart';
import 'package:flutter_application_5/common/utils/cache_helper.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountbookApiProvider = Provider<AccountbookApiProvider>((ref) {
  final dio = ref.read(dioProvider);
  return AccountbookApiProvider(dio);
});

class AccountbookApiProvider {
  final Dio _dio;

  AccountbookApiProvider(this._dio);

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




/// controller class ///
import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_model.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accountbook_controller.g.dart';

// Controller(Notifier)는 "화면 상태 관리 역할"
@riverpod
class AccountbookController extends _$AccountbookController {
  AccountbookRepository get _repository => ref.read(accountbookRepositoryProvider);

  @override
  FutureOr<RootFinance<ServerTimeDetail>?> build() async {
    return _repository.fetchServerTime();
  }
}



/// model class ///
import 'package:json_annotation/json_annotation.dart';

part 'accountbook_model.g.dart';

/// 1️⃣ Server Time API
@JsonSerializable()
class ServerTimeDetail {
  @JsonKey(name: 'Detail')
  final ServerTime? detail;
  
  ServerTimeDetail({this.detail});

  factory ServerTimeDetail.fromJson(Map<String, dynamic> json) =>
      _$ServerTimeDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ServerTimeDetailToJson(this);
}

@JsonSerializable()
class ServerTime {
  @JsonKey(name: 'SvrTime')
  final String? svrTime;

  ServerTime({this.svrTime});

  factory ServerTime.fromJson(Map<String, dynamic> json) =>
      _$ServerTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ServerTimeToJson(this);
}

/// 3️⃣ Action API
@JsonSerializable()
class FinanceActionDetail {
  @JsonKey(name: 'Result')
  final String? result;

  FinanceActionDetail({this.result});

  factory FinanceActionDetail.fromJson(Map<String, dynamic> json) =>
      _$FinanceActionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$FinanceActionDetailToJson(this);
}



/// repository class ///
import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_api_provider.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository는 "데이터를 가져오는 역할"
final accountbookRepositoryProvider = Provider<AccountbookRepository>((ref) {
  final apiProvider = ref.read(accountbookApiProvider);
  return AccountbookRepository(apiProvider);
});

class AccountbookRepository {
  final AccountbookApiProvider _apiProvider;

  AccountbookRepository(this._apiProvider);

  Future<RootFinance<ServerTimeDetail>?> fetchServerTime() async {
    try {
      final response = await _apiProvider.getServerTime();
      return response.data; // <-- RootFinance<T>?
    } catch (e) {
      throw Exception('Failed to load example data');
    }
  }
}



/// ui class ///
import 'package:flutter/material.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountbookScreen extends ConsumerWidget {
  const AccountbookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final accountbooks = ref.watch(accountbookRepositoryProvider);
    final accountbooks = ref.watch(accountbookControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('사용자 목록')),
      body: accountbooks.when(
        data: (data) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Title: ${data?.finance?.body?.detail?.svrTime}'),
              Text('Content: ${data?.finance?.body?.detail?.svrTime}'),
              SizedBox(height: 20),
            ],
          ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('오류: $err')),
      ),
    );
  }
}
