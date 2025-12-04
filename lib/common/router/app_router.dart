import 'package:flutter_application_5/presentation/accountbook/widget/accountbook_screen.dart';
import 'package:flutter_application_5/presentation/dashboard/widget/dashboard_screen.dart';
import 'package:flutter_application_5/presentation/login/widget/login_screen.dart';
import 'package:flutter_application_5/presentation/main_tab_screen.dart';
import 'package:flutter_application_5/presentation/splash/widget/splash_screen.dart';
import 'package:flutter_application_5/presentation/webview/widget/webview_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      /// Login Pin
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(loginType: ''),
      ),
      /// 🔥 URL extra 로 받는 WebView 화면
      GoRoute(
        path: '/webview',
        builder: (context, state) {
          final url = state.extra as String?;
          return WebViewScreen(url: url ?? 'about:blank');
        },  
      ),
      // ✅ 메인 탭 구조
      ShellRoute(
        builder: (context, state, child) => MainTabScreen(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/accountbook',
            name: 'accountbook',
            builder: (context, state) => const AccountbookScreen(),
          ),
        ],
      ),
    ],
  );
});