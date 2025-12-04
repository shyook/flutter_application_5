
import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/presentation/login/application/login_model.dart';
import 'package:flutter_application_5/presentation/login/application/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  LoginRepository get _repository => ref.read(loginRepositoryProvider);

  // PinRegister? resultRegisterInfo;
  // PinVerify? resultVerifyInfo;

  @override
  FutureOr<RootFinance<PinStatusDetail>?> build() {
    return checkPinStatus(); // UI 로딩 시점에선 초기값 X
  }

  /// 👉 PIN 상태 체크 
  Future<RootFinance<PinStatusDetail>?> checkPinStatus() async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      return await _repository.checkPinStatus();
    });

    state = result;
    return result.value;
  }

  /// 👉 PIN 등록
  Future<RootFinance<PinRegisterDetail>?> registerPin(String pinCode, String type, String prevPinCode) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      return await _repository.registerPin(pinCode, type, prevPinCode);
    });
    state = result as AsyncValue<RootFinance<PinStatusDetail>?>;
    return result.value;
  }

    /// 👉 PIN 검증
  Future<RootFinance<PinVerifyDetail>?> verifyPin(String pinCode, String wordCode) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      return await _repository.verifyPin(pinCode, wordCode);
    });
    state = result as AsyncValue<RootFinance<PinStatusDetail>?>;
    return result.value;
  }

  // FutureOr<RootFinance<PinRegisterDetail>?> registerPin(String pinCode, String type, String prevPinCode) async {
  //   state = const AsyncLoading();

  //   state = await AsyncValue.guard(() async {
  //     return await _repository.registerPin(pinCode, type, prevPinCode);
  //   });
  // }

  // Future<void> registerPin(String pinCode, String type, String prevPinCode) async {
  //   state = const AsyncLoading();

  //   try {
  //     final registerInfo = await _repository.registerPin(pinCode, type, prevPinCode);
  //     if (registerInfo == null || registerInfo.finance?.header.code != '10000') {
  //       throw Exception("registerInfo is null or no success");
  //     }
  //     resultRegisterInfo = registerInfo.finance?.body?.detail;
  //     state = AsyncData(registerInfo as RootFinance<PinStatusDetail>?); // ✅ 성공 상태
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //   }
  // }

  // Future<void> verifyPin(String pinCode, String wordCode) async {
  //   state = const AsyncLoading();

  //   try {
  //     final verifyInfo = await _repository.verifyPin(pinCode, wordCode);
  //     if (verifyInfo == null || verifyInfo.finance?.header.code != '10000') {
  //       throw Exception("verifyInfo is null or no success");
  //     }
  //     resultVerifyInfo = verifyInfo.finance?.body?.detail;
  //     state = AsyncData(resultVerifyInfo as RootFinance<PinStatusDetail>?); // ✅ 성공 상태
  //   } catch (e, st) {
  //       state = AsyncError(e, st);
  //     }
  // }
}