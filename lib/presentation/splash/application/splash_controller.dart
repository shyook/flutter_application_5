// Controller(Notifier)는 "화면 상태 관리 역할"
import 'package:flutter_application_5/common/utils/cache_helper.dart';
import 'package:flutter_application_5/presentation/splash/application/splash_model.dart';
import 'package:flutter_application_5/presentation/splash/application/splash_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_controller.g.dart';

@Riverpod(keepAlive: true)
class SplashController extends _$SplashController {
  SplashRepository get _repository => ref.read(splashRepositoryProvider);

  SessionAuth? sessionAuthDetailInfo;

  @override
  Future<void> build() async {
    return;
  }

  Future<void> run() async {
    state = const AsyncLoading();

    try {
      // 1️⃣ 세션 호출
      final session = await _repository.fetchSession();
      if (session == null || session.finance?.header.code != '10000') {
        throw Exception("Session is null");
      }

      final sessionInfo = session.finance?.body?.detail;
      CacheHelper.setEncData(sessionInfo?.encKey, sessionInfo?.encSeq);

      // 2️⃣ 세션 인증 호출
      final sessionAuth = await _repository.fetchSessionAuth();
      if (sessionAuth == null || sessionAuth.finance?.header.code != '10000') {
        throw Exception("sessionAuth is null");
      }

      final sessionAuthInfo = sessionAuth.finance?.body?.detail;
      CacheHelper.setSessionAuth(sessionAuthInfo);
      sessionAuthDetailInfo = sessionAuthInfo;

      state = const AsyncData(null); // ✅ 성공 상태
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Future<void> createArticle(ArticleModel article) async {
  //   await _repository.createArticle(article);
  // }
}