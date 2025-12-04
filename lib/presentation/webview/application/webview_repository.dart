import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'webview_url_provider.dart';

final webViewRepositoryProvider = Provider<WebViewRepository>((ref) {
  final url = ref.watch(webViewUrlProvider);
  return WebViewRepository(url);
});

class WebViewRepository {
  final String url;
  WebViewRepository(this.url);

  Future<WebViewController> createController(
    Function(String) onJsMessage,
  ) async {
    // 1) 미리 선언
    final controller = WebViewController();

    // 2) 설정 분리
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    controller.addJavaScriptChannel(
      'FlutterChannel',
      onMessageReceived: (message) => onJsMessage(message.message),
    );

    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (loadedUrl) {
          final flutterData = '{"msg":"Hello from Flutter!"}';
          controller.runJavaScript("receiveFromFlutter($flutterData);");
        },
      ),
    );

    // 3) URL 로딩
    await controller.loadRequest(Uri.parse(url));

    return controller;
  }
}