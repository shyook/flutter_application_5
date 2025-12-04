import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'webview_repository.dart';

part 'webview_controller.g.dart';

@riverpod
class WebViewControllerNotifier extends _$WebViewControllerNotifier {
  WebViewRepository get _repository => ref.read(webViewRepositoryProvider);

  @override
  FutureOr<WebViewController?> build() async {
    return _repository.createController(_handleJsMessage);
  }

  void _handleJsMessage(String msg) {
    print("JS 메시지 수신: $msg");
  }
}