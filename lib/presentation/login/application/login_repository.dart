import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/presentation/login/application/login_api_provider.dart';
import 'package:flutter_application_5/presentation/login/application/login_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final api = ref.read(loginApiProvider);
  return LoginRepository(api);
});

class LoginRepository {
  final LoginApiProvider _api;

  LoginRepository(this._api);

  Future<RootFinance<PinStatusDetail>?> checkPinStatus() async {
    final response = await _api.checkPinStatus();
    return response.data;
  }

  Future<RootFinance<PinRegisterDetail>?> registerPin(String pinCode, String type, String prevPinCode) async {
    final response = await _api.registerPin(pinCode, type, prevPinCode);
    return response.data;
  }

  Future<RootFinance<PinVerifyDetail>?> verifyPin(String pinCode, String wordCode) async {
    final response = await _api.verifyPin(pinCode, wordCode);
    return response.data;
  }
}