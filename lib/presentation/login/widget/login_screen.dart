import 'package:flutter/material.dart';
import 'package:flutter_application_5/presentation/login/application/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    String title = "";
    String subTitle = "";

    switch (state.mode) {
      case PinMode.verify:
        title = "비밀번호 인증";
        subTitle = "비밀번호를 입력해 주세요.";
        break;
      case PinMode.register:
        title = "비밀번호 설정";
        subTitle = "새 비밀번호를 입력해 주세요.";
        break;
      case PinMode.confirm:
        title = "비밀번호 재확인";
        subTitle = "확인을 위해 한 번 더 입력해 주세요.";
        break;
      case PinMode.success:
        Future.microtask(() => context.go('/accountbook'));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF673AB7),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 120),
            Text(title,
                style: const TextStyle(fontSize: 28, color: Colors.white)),
            const SizedBox(height: 12),
            Text(subTitle,
                style: const TextStyle(fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 40),

            /// ●●●○○○ PIN indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                final filled = index < state.input.length;
                return Container(
                  margin: const EdgeInsets.all(6),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: filled ? Colors.white : Colors.white38,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),

            if (state.errorText != null) ...[
              const SizedBox(height: 14),
              Text(
                state.errorText!,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ],

            const SizedBox(height: 10),

            // 자동로그인 / 생체인증
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoLoginToggle(),
                const SizedBox(width: 40),
                BioLoginToggle(),
              ],
            ),

            const Spacer(),

            /// Keypad
            _keypad(
              onNumber: controller.inputNumber,
              onDelete: controller.delete,
              shuffledKeys: state.shuffledKeys,
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {},
              child: const Text(
                "비밀번호를 잊으셨나요?",
                style: TextStyle(color: Colors.white70, fontSize: 14, decoration: TextDecoration.underline),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildBioButton(PinState state, VoidCallback onBioAuth) {
    // PIN 등록 모드에서는 숨김
    if (state.mode != PinMode.verify) {
      return const SizedBox.shrink();
    }

    // 생체 인증이 가능한 경우에만 보여줌
    // if (!state.bioEnabled) {
    //   return const SizedBox.shrink();
    // }

    return GestureDetector(
      onTap: onBioAuth,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.fingerprint, color: Colors.white, size: 20),
            SizedBox(width: 6),
            Text(
              "생체 인증",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _keypad({
    required Function(int) onNumber,
    required VoidCallback onDelete,
    required List<int> shuffledKeys,
  }) {
    final items = [
      ...shuffledKeys.sublist(0, 9), // 1~9
      -1,                            // 빈칸
      shuffledKeys[9],               // 0
      -2,                            // 삭제
    ];

    return SizedBox(
      height: 350, // 필요 시 조정 가능 (모든 해상도에서 동일)
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,       // 항상 3열 고정
          childAspectRatio: 1.6,   // 버튼 모양 비율 (필요 시 조정)
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          final num = items[index];

          if (num == -1) {
            return const SizedBox.shrink(); // 빈칸
          } else if (num == -2) {
            return Center(
              child: IconButton(
                icon: const Icon(Icons.backspace, color: Colors.white),
                iconSize: 32,
                onPressed: onDelete,
              ),
            );
          }

          return Center(
            child: TextButton(
              onPressed: () => onNumber(num),
              child: Text(
                "$num",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AutoLoginToggle extends ConsumerWidget {
  const AutoLoginToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    return GestureDetector(
      onTap: controller.toggleAutoLogin,
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 2,
              ),
              color: state.autoLogin
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: state.autoLogin
                ? const Icon(Icons.check, color: Colors.white, size: 13)
                : null,
          ),
          const SizedBox(width: 8),
          const Text(
            "자동로그인",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class BioLoginToggle extends ConsumerWidget {
  const BioLoginToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    // PIN 등록 모드면 숨김
    if (state.mode == PinMode.register) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: controller.toggleBioEnabled,
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 2,
              ),
              color: state.bioEnabled
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: state.bioEnabled
                ? const Icon(Icons.check, color: Colors.white, size: 13)
                : null,
          ),
          const SizedBox(width: 8),
          const Text(
            "생체인증",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

//   Widget _keypad({
//   required Function(int) onNumber,
//   required VoidCallback onDelete,
//   required List<int> shuffledKeys,
// }) {
//   // 셔플된 키 10개를 3x4 레이아웃으로 매핑
//   final layout = [
//     shuffledKeys.sublist(0, 3),
//     shuffledKeys.sublist(3, 6),
//     shuffledKeys.sublist(6, 9),
//     [-1, shuffledKeys[9], -2],
//   ];

//   return Column(
//     children: layout.map((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: row.map((num) {
//           if (num == -1) {
//             return const SizedBox(width: 80);
//           } else if (num == -2) {
//             return IconButton(
//               icon: const Icon(Icons.backspace, color: Colors.white),
//               onPressed: onDelete,
//             );
//           }
//           return TextButton(
//             onPressed: () => onNumber(num),
//             child: Text(
//               "$num",
//               style: const TextStyle(color: Colors.white, fontSize: 32),
//             ),
//           );
//         }).toList(),
//       );
//     }).toList(),
//   );
//   }
// }


// class LoginScreen extends ConsumerStatefulWidget {
//   final String loginType;
//   const LoginScreen({super.key, required this.loginType});

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   String pin = '';

//   @override
//   void initState() {
//     super.initState();
//     // run() 호출 → API 실행
//     Future.microtask(() {
//       ref.read(loginControllerProvider.notifier).checkPinStatus();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pinState = ref.watch(loginControllerProvider);

//     ref.listen(loginControllerProvider, (prev, next) {
//       next.whenOrNull(
//         data: (_) {
//           final pinStatusInfo = ref.read(loginControllerProvider.notifier).checkPinStatus;
//         }
//       );
//     });
//     return Scaffold(
//       backgroundColor: const Color(0xFF663ECB),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             const Text(
//               "비밀번호 인증",
//               style: TextStyle(
//                 fontSize: 28,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Text(
//               "확인을 위해 한 번 더 입력해 주세요.",
//               style: TextStyle(color: Colors.white70),
//             ),

//             /// Dot indicator
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(6, (index) {
//                 final filled = index < pin.length;
//                 return Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 6),
//                   width: 16,
//                   height: 16,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: filled ? Colors.white : Colors.white38,
//                   ),
//                 );
//               }),
//             ),

//             if (pinState.isLoading)
//               const CircularProgressIndicator(color: Colors.white),

//             /// Number pad
//             Column(
//               children: [
//                 buildRow(["1", "2", "3"]),
//                 buildRow(["4", "5", "6"]),
//                 buildRow(["7", "8", "9"]),
//                 buildRow(["", "0", "←"]),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildRow(List<String> numbers) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: numbers.map((n) {
//         if (n == "") return const SizedBox(width: 80);

//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               if (n == "←") {
//                 if (pin.isNotEmpty) pin = pin.substring(0, pin.length - 1);
//               } else if (pin.length < 6) {
//                 pin += n;
//               }
//             });

//             if (pin.length == 6) {
//               ref.read(loginControllerProvider.notifier).checkPinStatus();
//             }
//           },
//           child: SizedBox(
//             width: 80,
//             height: 80,
//             child: Center(
//               child: Text(
//                 n,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 34,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   void resetPin() {
//     setState(() => pin = "");
//   }
// }