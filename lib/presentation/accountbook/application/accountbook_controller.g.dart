// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountbook_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountbookController)
const accountbookControllerProvider = AccountbookControllerProvider._();

final class AccountbookControllerProvider
    extends
        $AsyncNotifierProvider<
          AccountbookController,
          RootFinance<ServerTimeDetail>?
        > {
  const AccountbookControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountbookControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountbookControllerHash();

  @$internal
  @override
  AccountbookController create() => AccountbookController();
}

String _$accountbookControllerHash() =>
    r'b2aa3085dd64da59a85ece0c2999c6bd996fcd42';

abstract class _$AccountbookController
    extends $AsyncNotifier<RootFinance<ServerTimeDetail>?> {
  FutureOr<RootFinance<ServerTimeDetail>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<RootFinance<ServerTimeDetail>?>,
              RootFinance<ServerTimeDetail>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<RootFinance<ServerTimeDetail>?>,
                RootFinance<ServerTimeDetail>?
              >,
              AsyncValue<RootFinance<ServerTimeDetail>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
