import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_5/common/utils/shared_preferences_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

// class WebViewDebugPage extends ConsumerStatefulWidget {
//   const WebViewDebugPage({super.key});

//   @override
//   ConsumerState<WebViewDebugPage> createState() => _WebViewDebugPageState();
// }

// class _WebViewDebugPageState extends ConsumerState<WebViewDebugPage> {
//   late WebViewController controller;
//   String log = "";

//   void addLog(String text) {
//     setState(() => log += "$text\n");
//     print(text);
//   }

//   @override
//   void initState() {
//     super.initState();

//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..addJavaScriptChannel(
//         "FlutterChannel",
//         onMessageReceived: (msg) {
//           addLog("📩 JS → Flutter: ${msg.message}");
//         },
//       )
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (url) {
//             addLog("✅ Page Loaded: $url");
//             controller.runJavaScript(_appBridgeJs);
//             addLog("🟢 Bridge Injected.");
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse("https://example.com/webview_test.html"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("WebView Bridge Debug")),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   controller.runJavaScript(
//                       "console.log('[Flutter → JS] test call');");
//                 },
//                 child: const Text("Test JS Console"),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final exists = await controller
//                       .runJavaScriptReturningResult("typeof window.AchaApp");
//                   addLog("🔍 JS window.AchaApp: $exists");
//                 },
//                 child: const Text("Check AchaApp"),
//               ),
//             ],
//           ),
//           Expanded(child: WebViewWidget(controller: controller)),
//           Container(
//             height: 180,
//             padding: const EdgeInsets.all(8),
//             color: Colors.black87,
//             child: SingleChildScrollView(
//               child: Text(
//                 log,
//                 style: const TextStyle(color: Colors.green),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController();

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.addJavaScriptChannel(
      'FlutterChannel',
      // onMessageReceived: (msg) => print("JS: ${msg.message}"),
      onMessageReceived: (msg) {
        final data = jsonDecode(msg.message);

        print("call native call ${data['type']}");
        switch (data['type']) {
          case "setPinNum":
            context.go('/login', extra: '');
            break;
          case "joinComplete":
            SharedPreferencesHelper.setData(key: SharedPreferencesHelper.key_member_id, value: data['memberId']);
            SharedPreferencesHelper.setData(key: SharedPreferencesHelper.key_user_check, value: data['chkKey']);
            SharedPreferencesHelper.setData(key: SharedPreferencesHelper.key_phone_number, value: data['ctn']);
            break;
        }
      }
    );
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (url) {
          // JS Adapter 삽입
          print("🔥 Page Loaded");
          controller.runJavaScript(_appBridgeJs);
          print("🔥 JS Bridge Injected");
        },
      ),
    );

    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("WebView")),
      body: WebViewWidget(controller: controller),
    );
  }
}

const String _appBridgeJs = """
// Android
if (!window.AchaApp) {
  window.AchaApp = {};
}

// reload
window.AchaApp.webViewReload = function() {
  if (window.FlutterChannel) {
    window.FlutterChannel.postMessage(JSON.stringify({
      type: "reload"
    }));
  }
};

// close
window.AchaApp.webViewClose = function() {
  if (window.FlutterChannel) {
    window.FlutterChannel.postMessage(JSON.stringify({
      type: "close"
    }));
  }
};

// setPinNum
window.AchaApp.setPinNum = function() {
  if (window.FlutterChannel) {
    window.FlutterChannel.postMessage(JSON.stringify({
      type: "setPinNum"
    }));
  }
};

// joinComplete
window.AchaApp.joinComplete = function(memberId, memberStatus, chkKey, ctn) {
  if (window.FlutterChannel) {
    window.FlutterChannel.postMessage(JSON.stringify({
      type: "joinComplete",
      memberId: memberId,
      memberStatus: memberStatus,
      chkKey: chkKey,
      ctn: ctn
    }));
  }
};

// ⚡ Android reAuth(파라미터 포함)
window.AchaApp.reAuth = function(reAuthType) {
  if (window.FlutterChannel) {
    window.FlutterChannel.postMessage(JSON.stringify({
      type: "reAuth",
      reAuthType: reAuthType
    }));
  }
};

// -----------------------
// iOS bridge mapping
// -----------------------
if (window.webkit && window.webkit.messageHandlers) {
  // iOS reload
  window.webkit.messageHandlers.webViewReload = {
    postMessage: function(obj) {
      if (window.FlutterChannel) {
        window.FlutterChannel.postMessage(JSON.stringify({
          type: "reload"
        }));
      }
    }
  };

  // iOS close
  window.webkit.messageHandlers.webViewClose = {
    postMessage: function(obj) {
      if (window.FlutterChannel) {
        window.FlutterChannel.postMessage(JSON.stringify({
          type: "close"
        }));
      }
    }
  };

  // iOS setPinNum
  window.webkit.messageHandlers.setPinNum = {
    postMessage: function(obj) {
      if (window.FlutterChannel) {
        window.FlutterChannel.postMessage(JSON.stringify({
          type: "setPinNum"
        }));
      }
    }
  };

  // iOS joinComplete
  window.webkit.messageHandlers.joinComplete = {
    postMessage: function(obj) {
      if (window.FlutterChannel) {
        window.FlutterChannel.postMessage(JSON.stringify({
          type: "joinComplete",
          memberId: obj?.MemberId,
          memberStatus: obj?.MemberStatus,
          chkKey: obj?.ChkKey,
          ctn: obj?.Ctn,
          memberName: obj?.MemberName,
          adultYn: obj?.AdultYn,
          newTermsAgreeTargetYn: obj?.NewTermsAgreeTargetYn
        }));
      }
    }
  };

  // ⚡ iOS reAuth(파라미터 포함)
  window.webkit.messageHandlers.reAuth = {
    postMessage: function(obj) {
      if (window.FlutterChannel) {
        window.FlutterChannel.postMessage(JSON.stringify({
          type: "reAuth",
          reAuthType: obj?.ReAuthType
        }));
      }
    }
  };
}
""";