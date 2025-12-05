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
    extends $NotifierProvider<LoginController, PinState> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PinState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PinState>(value),
    );
  }
}

String _$loginControllerHash() => r'6def71ce02f74bf7e5d0dd4b01328b22284647a9';

abstract class _$LoginController extends $Notifier<PinState> {
  PinState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PinState, PinState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PinState, PinState>,
              PinState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
