// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginController)
const loginControllerProvider = LoginControllerProvider._();

final class LoginControllerProvider
    extends
        $AsyncNotifierProvider<LoginController, RootFinance<PinStatusDetail>?> {
  const LoginControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginControllerHash();

  @$internal
  @override
  LoginController create() => LoginController();
}

String _$loginControllerHash() => r'286c88376d44d4a111dfcc109b5a6cb0dd4b4703';

abstract class _$LoginController
    extends $AsyncNotifier<RootFinance<PinStatusDetail>?> {
  FutureOr<RootFinance<PinStatusDetail>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<RootFinance<PinStatusDetail>?>,
              RootFinance<PinStatusDetail>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<RootFinance<PinStatusDetail>?>,
                RootFinance<PinStatusDetail>?
              >,
              AsyncValue<RootFinance<PinStatusDetail>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
