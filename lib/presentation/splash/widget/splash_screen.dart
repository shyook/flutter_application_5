import 'package:flutter/material.dart';
import 'package:flutter_application_5/presentation/splash/application/splash_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  double _animationDuration = 2.0; // 기본값 2초, Lottie 로딩 후 수정

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);

    // run() 호출 → API 실행
    Future.microtask(() {
      ref.read(splashControllerProvider.notifier).run();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          // API 완료 + 애니메이션 재생 완료 후 이동
          Future.delayed(Duration(milliseconds: (_animationDuration * 1000).toInt()))
              .then((_) => context.go('/home'));
        },
        error: (e, _) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("오류: $e")));
        },
      );
    });

    final splash = ref.watch(splashControllerProvider);

    return Scaffold(
      body: splash.when(
        data: (_) => Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(68, 0, 68, 150),
            child: Lottie.asset(
              'assets/animations/intro_splash.json',
              controller: _animationController,
              repeat: false,
              onLoaded: (composition) {
                // 🔹 Lottie 전체 길이 가져오기
                _animationDuration = composition.duration.inMilliseconds / 1000;
                _animationController
                  ..duration = composition.duration
                  ..forward(); // 애니메이션 시작
              },
            ),
          ),
        ),
        loading: () => const SizedBox.shrink(),
        error: (err, _) => Center(child: Text('오류: $err')),
      ),
    );
  }
}

// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   ConsumerState<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends ConsumerState<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     // run() 호출 → build() 대신 명령형 실행
//     Future.microtask(() {
//       ref.read(splashControllerProvider.notifier).run();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ✅ listen은 build 최상단
//     ref.listen(
//       splashControllerProvider,
//       (prev, next) {
//         next.whenOrNull(
//           data: (_) {
//             context.go('/home'); // API 성공 후 이동
//           },
//           error: (e, _) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text("오류: $e")));
//           },
//         );
//       },
//     );

//     final splash = ref.watch(splashControllerProvider);

//     return Scaffold(
//       body: splash.when(
//         data: (_) => Center(
//           child: Container(
//             width: double.infinity,
//             margin: const EdgeInsets.fromLTRB(68, 0, 68, 150),
//             child: Lottie.asset(
//               'assets/animations/intro_splash.json',
//               repeat: true,
//               animate: true,
//             ),
//           ),
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, _) => Center(child: Text('오류: $err')),
//       ),
//     );
//   }
// }

// class SplashScreen extends ConsumerWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final accountbooks = ref.watch(accountbookRepositoryProvider);
//     ref.listen(
//       splashControllerProvider,
//       (prev, next) {
//         // 1️⃣ API 성공 → AsyncData 상태일 때
//         if (next.hasValue) {
//           // 2️⃣ 다음 화면으로 이동
//           context.go('/home'); // ✅ 스플래시 후 메인 탭으로 이동
//         }
//       },
//     );

//     final splash = ref.watch(splashControllerProvider);

//     return Scaffold(
//       body: splash.when(
//         data: (data) => Center(
//           child: Container(
//             width: double.infinity,
//             margin: EdgeInsets.fromLTRB(68, 0, 68, 150),
//             child: Lottie.asset(
//               'assets/animations/intro_splash.json', 
//               repeat: true, 
//               animate: true
//             ),
//             // Image.asset(
//             //   'assets/images/imgSplash@3x.png',
//             //   fit: BoxFit.cover,
//             //   alignment: Alignment.center,
//             //   ),
//           ),
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, _) => Center(child: Text('오류: $err')),
//       ),
//     );
//   }
// }