import 'package:flutter/material.dart';
import 'package:flutter_application_5/presentation/login/application/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class LoginScreen extends ConsumerWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(loginControllerProvider);

//     // API 로딩 중
//     if (state.hasPin == null || state.loading) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(color: Colors.white),
//         ),
//         backgroundColor: Color(0xFF6448C8),
//       );
//     }

//     // 서버에 PIN이 이미 있음 → PIN 인증 화면
//     if (state.hasPin == true) {
//       return const PinVerifyScreen();
//     }

//     // PIN 없음 → PIN 등록 화면
//     return const PinRegisterScreen();
//   }
// }


class LoginScreen extends ConsumerStatefulWidget {
  final String loginType;
  const LoginScreen({super.key, required this.loginType});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String pin = '';

  @override
  void initState() {
    super.initState();
    // run() 호출 → API 실행
    Future.microtask(() {
      ref.read(loginControllerProvider.notifier).checkPinStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pinState = ref.watch(loginControllerProvider);

    ref.listen(loginControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          // final res = result?.finance?.body?.detail;
          final pinStatusInfo = ref.read(loginControllerProvider.notifier).checkPinStatus;
        }
      );
    });
    return Scaffold(
      backgroundColor: const Color(0xFF663ECB),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "비밀번호 인증",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "확인을 위해 한 번 더 입력해 주세요.",
              style: TextStyle(color: Colors.white70),
            ),

            /// Dot indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                final filled = index < pin.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? Colors.white : Colors.white38,
                  ),
                );
              }),
            ),

            if (pinState.isLoading)
              const CircularProgressIndicator(color: Colors.white),

            /// Number pad
            Column(
              children: [
                buildRow(["1", "2", "3"]),
                buildRow(["4", "5", "6"]),
                buildRow(["7", "8", "9"]),
                buildRow(["", "0", "←"]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((n) {
        if (n == "") return const SizedBox(width: 80);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (n == "←") {
                if (pin.isNotEmpty) pin = pin.substring(0, pin.length - 1);
              } else if (pin.length < 6) {
                pin += n;
              }
            });

            if (pin.length == 6) {
              ref.read(loginControllerProvider.notifier).checkPinStatus();
            }
          },
          child: SizedBox(
            width: 80,
            height: 80,
            child: Center(
              child: Text(
                n,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void resetPin() {
    setState(() => pin = "");
  }
}