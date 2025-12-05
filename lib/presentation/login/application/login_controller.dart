
import 'dart:math';

import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/common/utils/cache_helper.dart';
import 'package:flutter_application_5/common/utils/crypto_helper.dart';
import 'package:flutter_application_5/presentation/login/application/login_model.dart';
import 'package:flutter_application_5/presentation/login/application/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

enum PinMode {
  verify,     // PIN 검증
  register,   // PIN 최초 등록
  confirm,    // PIN 재확인
  success,    // 성공 화면 이동 
}

class PinState {
  final PinMode mode;
  final List<int> input;
  final List<int> tempRegisterPin;
  final List<int> shuffledKeys;
  final bool loading;
  final bool autoLogin;
  final bool bioEnabled;
  final String? errorText;

  PinState({
    required this.mode,
    this.input = const [],
    this.tempRegisterPin= const [],
    this.shuffledKeys = const [],
    this.loading = false,
    this.autoLogin = false,
    this.bioEnabled = false,
    this.errorText,
  });

  PinState copyWith({
    PinMode? mode,
    List<int>? input,
    List<int>? tempRegisterPin,
    List<int>? shuffledKeys,
    bool? loading,
    bool? autoLogin,
    bool? bioEnabled,
    String? errorText,
  }) {
    return PinState(
      mode: mode ?? this.mode,
      input: input ?? this.input,
      tempRegisterPin: tempRegisterPin ?? this.tempRegisterPin,
      shuffledKeys: shuffledKeys ?? this.shuffledKeys,
      loading: loading ?? this.loading,
      autoLogin: autoLogin ?? this.autoLogin,
      bioEnabled: bioEnabled ?? this.bioEnabled,
      errorText: errorText,
    );
  }
}

@riverpod
class LoginController extends Notifier<PinState> {
  LoginRepository get _repository => ref.read(loginRepositoryProvider);

  @override
  PinState build() {
    _init();
    return PinState(
      mode: PinMode.verify,
      shuffledKeys: _shuffleKeys(),
    ); 
  }

  Future<void> _init() async {
    final response = await _checkPinStatus();

    var hasPin = response?.finance?.body?.detail?.pinNumYn == 'Y';
    print('_init : ${hasPin}');
    state = state.copyWith(
      mode: hasPin ? PinMode.verify : PinMode.register,
      shuffledKeys: _shuffleKeys(),
    );
  }

  /// 👉 PIN 상태 체크 
  Future<RootFinance<PinStatusDetail>?> _checkPinStatus() async {
    final result = await AsyncValue.guard(() async {
      return await _repository.checkPinStatus();
    });

    return result.value;
  }

  /// 👉 PIN 등록
  Future<void> _registerPin() async {
    final pinCode = state.input.join();
    if (state.mode == PinMode.confirm && state.tempRegisterPin.join() != state.input.join()) {
      // 불일치
      state = state.copyWith(
        input: [],
        tempRegisterPin: null,
        mode: PinMode.register,
        errorText: "입력하신 번호가 일치하지 않습니다.",
      );
      return;
    }

    // PIN 번호 등록 및 검증 코드 전달
    // - R : PIN번호 등록
    // - U : PIN번호 변경
    // - V : PIN번호 검증
    final type = state.mode == PinMode.register ? 'V' : 'R';

    final result = await _repository.registerPin(pinCode, type, '');

    final authResultCode = result?.finance?.body?.detail?.authResultCode ?? '';
    final authResult = CryptHelper.decryptByAes(CacheHelper.getEncKey(), authResultCode).trim();

    print('_registerPin : ${authResult}');
    if (authResult == 'PASS' && type == 'V') {
      // 화면 이동 
      state = state.copyWith(
        tempRegisterPin: [...state.input],
        input: [],
        mode: PinMode.confirm,
        shuffledKeys: _shuffleKeys(),
      );
    } else if (authResult == 'PASS' && type == 'R') {
      state = state.copyWith(
        mode: PinMode.success,
      );
    } else {
      // 에러 팝업 
    }
  }

    /// 👉 PIN 검증
  Future<void> _verifyPin() async {
    final pinCode = state.input.join();
    final wordCode = 'code';
    final result = await _repository.verifyPin(pinCode, wordCode);
    final authResultCode = result?.finance?.body?.detail?.authResultCode ?? '';
    final authResult = CryptHelper.decryptByAes(CacheHelper.getEncKey(), authResultCode).trim();

    if (authResult == 'PASS') {
      state = state.copyWith(
        mode: PinMode.success,
      );
    } else {
      // 에러 팝업 
    }
  }

  /// 숫자 입력
  void inputNumber(int num) {
    if (state.input.length >= 6) return;
    state = state.copyWith(input: [...state.input, num]);

    if (state.input.length == 6) {
      _onComplete();
    }
  }

  /// 삭제
  void delete() {
    if (state.input.isEmpty) return;
    state = state.copyWith(
      input: [...state.input]..removeLast(),
    );
  }

  void shuffleKeypad() {
    state = state.copyWith(shuffledKeys: _shuffleKeys());
  }

  /// 입력 초기화 + 숫자 재셔플
  void resetInput() {
    state = state.copyWith(
      shuffledKeys: _shuffleKeys(),
    );
  }

  /// 숫자 0~9 셔플
  List<int> _shuffleKeys() {
    final keys = List<int>.generate(10, (i) => i);
    keys.shuffle();
    return keys;
  }

  // PIN 입력 6자리 완료 시 처리
  Future<void> _onComplete() async {
    switch (state.mode) {
      case PinMode.verify:
        await _verifyPin();
        break;

      case PinMode.register:
        await _registerPin();
        break;

      case PinMode.confirm:
        await _registerPin();
        break;
      default:
        break;
    }
  }

  void toggleAutoLogin() {
    state = state.copyWith(autoLogin: !state.autoLogin);
  }

  void toggleBioEnabled() {
    state = state.copyWith(bioEnabled: !state.bioEnabled);
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