import 'package:flutter_application_5/common/models/response_base.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_model.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accountbook_controller.g.dart';

class AccountMainState {
  final bool isLoading;
  final AccountBookReportDetail? summary;
  final AccountBookIncomeDetail? income;
  final String? error;

  AccountMainState({
    this.isLoading = false,
    this.summary,
    this.income,
    this.error,
  });

  AccountMainState copyWith({
    bool? isLoading,
    AccountBookReportDetail? summary,
    AccountBookIncomeDetail? income,
    String? error,
  }) {
    return AccountMainState(
      isLoading: isLoading ?? this.isLoading,
      summary: summary ?? this.summary,
      income: income ?? this.income,
      error: error,
    );
  }
}
// Controller(Notifier)는 "화면 상태 관리 역할"
@riverpod
class AccountbookController extends Notifier<AccountMainState> {
  AccountbookRepository get _repository => ref.read(accountbookRepositoryProvider);

  @override
  AccountMainState build() {
    _init();
    return AccountMainState(
      isLoading: true,
    ); 
  }

  Future<void> _init() async {
    Future<RootFinance<AccountBookReportDetail>?> fetchReport = _fetchReport();

    List<String> results = await Future.wait([fetchReport, api2Future, api3Future]);

    var hasPin = response?.finance?.body?.detail?.pinNumYn == 'Y';
    print('_init : ${hasPin}');
    state = state.copyWith(
      mode: hasPin ? PinMode.verify : PinMode.register,
      shuffledKeys: _shuffleKeys(),
    );
  }

  Future<RootFinance<AccountBookReportDetail>?> _fetchReport() async {
    final result = await AsyncValue.guard(() async {
      return await _repository.fetchReport();
    });

    return result.value;
  }

  Future<RootFinance<AccountBookIncomeDetail>?> _fetchTotalIncome(String yyyyMM) async {
    final result = await AsyncValue.guard(() async {
      return await _repository.fetchTotalIncome(yyyyMM);
    });

    return result.value;
  }

  Future<void> load(String yyyyMM) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final summary = await service.loadSummary(month);
      final expenses = await service.loadExpenses(month);

      state = state.copyWith(
        isLoading: false,
        summary: summary,
        expenses: expenses,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Future<void> createArticle(ArticleModel article) async {
  //   await _repository.createArticle(article);
  // }
}