import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_model.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accountbook_controller.g.dart';

// Controller(Notifier)는 "화면 상태 관리 역할"
@riverpod
class AccountbookController extends _$AccountbookController {
  AccountbookRepository get _repository => ref.read(accountbookRepositoryProvider);

  @override
  FutureOr<RootFinance<ServerTimeDetail>?> build() async {
    return _repository.fetchServerTime();
  }

  /// 데이터 갱신이 필요한경우 예제.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.fetchServerTime());
  }

  // Future<void> createArticle(ArticleModel article) async {
  //   await _repository.createArticle(article);
  // }
}