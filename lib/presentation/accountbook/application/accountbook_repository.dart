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

  Future<RootFinance<AccountBookReportDetail>?> fetchReport() async {
    final response = await _apiProvider.fetchReport();
    return response.data;
  }

  Future<RootFinance<AccountBookIncomeDetail>?> fetchTotalIncome(String yyyyMM) async {
    final response = await _apiProvider.fetchTotalIncome(yyyyMM);
    return response.data;
  }

  // Future<void> createExample(FinanceSessionDetail example) async {
  //   try {
  //     await _apiProvider.postRequest('/example', example.toJson());
  //   } catch (e) {
  //     throw Exception('Failed to create example data');
  //   }
  // }
}