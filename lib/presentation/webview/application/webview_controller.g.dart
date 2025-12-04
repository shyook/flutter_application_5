// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WebViewControllerNotifier)
const webViewControllerProvider = WebViewControllerNotifierProvider._();

final class WebViewControllerNotifierProvider
    extends
        $AsyncNotifierProvider<WebViewControllerNotifier, WebViewController?> {
  const WebViewControllerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webViewControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webViewControllerNotifierHash();

  @$internal
  @override
  WebViewControllerNotifier create() => WebViewControllerNotifier();
}

String _$webViewControllerNotifierHash() =>
    r'544c934da9e94470cf425aa2037cfbc43b48562b';

abstract class _$WebViewControllerNotifier
    extends $AsyncNotifier<WebViewController?> {
  FutureOr<WebViewController?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<WebViewController?>, WebViewController?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WebViewController?>, WebViewController?>,
              AsyncValue<WebViewController?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
