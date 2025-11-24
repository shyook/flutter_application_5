import 'package:flutter/material.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountbookScreen extends ConsumerWidget {
  const AccountbookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final accountbooks = ref.watch(accountbookRepositoryProvider);
    final accountbooks = ref.watch(accountbookControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('사용자 목록')),
      body: accountbooks.when(
        data: (data) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Title: ${data?.finance?.body?.detail?.svrTime}'),
              Text('Content: ${data?.finance?.body?.detail?.svrTime}'),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => EditArticlePage(article: article)),
              //     );
              //   },
              //   child: Text('Edit Article'),
              // ),
            ],
          ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('오류: $err')),
      ),
    );
  }
}