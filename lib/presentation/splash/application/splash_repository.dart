import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/presentation/splash/application/splash_api_provider.dart';
import 'package:flutter_application_5/presentation/splash/application/splash_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashRepositoryProvider = Provider<SplashRepository>((ref) {
  final apiProvider = ref.read(splashApiProvider);
  return SplashRepository(apiProvider);
});

class SplashRepository {
  final SplashApiProvider _apiProvider;

  SplashRepository(this._apiProvider);

  Future<RootFinance<FinanceSessionDetail>?> fetchSession() async {
    try {
      final response = await _apiProvider.getSession();
      return response.data; // <-- RootFinance<T>?
    } catch (e) {
      throw Exception('Failed to load session data');
    }
  }

  Future<RootFinance<FinanceSessionAuthDetail>?> fetchSessionAuth() async {
    try {
      final response = await _apiProvider.getSessionAuth();
      return response.data; // <-- RootFinance<T>?
    } catch (e) {
      throw Exception('Failed to load session auth data');
    }
  }
}