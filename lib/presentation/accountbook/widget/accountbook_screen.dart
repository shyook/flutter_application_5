import 'package:flutter/material.dart';
import 'package:flutter_application_5/presentation/accountbook/application/accountbook_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountBookMainPage extends ConsumerStatefulWidget {
  const AccountBookMainPage({super.key});

  @override
  ConsumerState<AccountBookMainPage> createState() =>
      _AccountBookMainPageState();
}

class _AccountBookMainPageState extends ConsumerState<AccountBookMainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.watch(accountbookControllerProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(accountbookControllerProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text("Error: ${state.error}"));
    }

    final summary = state.summary!;
    final expenses = state.expenses;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _HeaderSection()),
            SliverToBoxAdapter(
              child: _SummaryCards(
                totalIncome: summary.totalIncome,
                totalExpectedExpense: summary.totalExpectedExpense,
                budget: summary.budget,
              ),
            ),
            SliverToBoxAdapter(child: _ExpenseSection(expenses: expenses)),
            CategoryBudgetSection(),   // ← 이것 추가
          ],
        ),
      ),
    );
  }
}

/// 🌟 1. 상단 헤더 영역
class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(),
          const SizedBox(height: 20),
          _MonthSelector(),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 프로필
        Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage("assets/profile.png"), // 변경 가능
            ),
            const SizedBox(width: 10),
            const Text(
              "김꼼꼼님",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),

        Row(
          children: [
            // 알림
            Stack(
              children: [
                const Icon(Icons.notifications_outlined, size: 30),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "90",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            const Icon(Icons.menu, size: 30),
          ],
        )
      ],
    );
  }
}

/// 🌟 2. 월 선택 + 리포트 + 업데이트 시간
class _MonthSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "11월",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.keyboard_arrow_down),

        const SizedBox(width: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: const [
              Icon(Icons.description_outlined, size: 18),
              SizedBox(width: 4),
              Text("리포트"),
            ],
          ),
        ),

        const Spacer(),

        Row(
          children: const [
            Text("2시간 전", style: TextStyle(color: Colors.grey)),
            SizedBox(width: 4),
            Icon(Icons.refresh, size: 16, color: Colors.grey),
          ],
        ),
      ],
    );
  }
}

/// 🌟 3. 수입 · 지출 요약 카드
class _SummaryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _SummaryCard(
            title: "총 수입 예정",
            amount: "3,500,000원",
            color: const Color(0xFFD47CFF),
          ),
          const SizedBox(width: 12),
          _SummaryCard(
            title: "총 지출 예정",
            amount: "1,520,000원",
            subText: "예산 2,500,000원",
            color: Colors.deepPurpleAccent,
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String? subText;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.amount,
    this.subText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 6),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subText != null) ...[
              const SizedBox(height: 4),
              Text(
                subText!,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              )
            ]
          ],
        ),
      ),
    );
  }
}

/// 🌟 4. 지출 섹션 UI
class _ExpenseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ExpenseCard(
          title: "정기지출",
          expectedLabel: "지출 예정",
          expectedAmount: "50,000원",
          doneAmount: "0원",
          expectedCount: "1건",
        ),
        _ExpenseCard(
          title: "변동지출",
          expectedLabel: "지출 예산",
          expectedAmount: "2,500,000원",
          doneAmount: "0원",
        ),
        _ExpenseCard(
          title: "할부지출",
          expectedLabel: "지출 예정",
          expectedAmount: "50,000원",
          doneAmount: "0원",
          expectedCount: "1건",
        ),
      ],
    );
  }
}

class _ExpenseCard extends StatelessWidget {
  final String title;
  final String expectedLabel;
  final String expectedAmount;
  final String doneAmount;
  final String? expectedCount;

  const _ExpenseCard({
    required this.title,
    required this.expectedLabel,
    required this.expectedAmount,
    required this.doneAmount,
    this.expectedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),

            const SizedBox(height: 14),

            // 지출 예정 / 예산
            Row(
              children: [
                Text(expectedLabel, style: const TextStyle(color: Colors.grey)),
                if (expectedCount != null) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1E9FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      expectedCount!,
                      style: const TextStyle(fontSize: 12, color: Colors.deepPurple),
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  expectedAmount,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 지출 완료
            Row(
              children: [
                const Text("지출 완료", style: TextStyle(color: Colors.grey)),
                const Spacer(),
                Text(
                  doneAmount,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryBudgetSection extends StatelessWidget {
  const CategoryBudgetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      CategoryData("식비·외식비", 42, Colors.deepPurple),
      CategoryData("카페·간식", 22, Colors.purpleAccent),
      CategoryData("마트·편의점", 15, Colors.pinkAccent),
      CategoryData("이체", 9, Colors.orange),
      CategoryData("교육·강습", 6, Colors.amber),
      CategoryData("동아리", 3, Colors.indigoAccent),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목 + 편집 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "카테고리별 지출 예산",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("편집"),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 도넛 차트
          SizedBox(
            height: 260,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 70,
                    sections: data
                        .map((e) => PieChartSectionData(
                              color: e.color,
                              value: e.percent.toDouble(),
                              title: "",
                              radius: 90,
                            ))
                        .toList(),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "마트·편의점",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "15%",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 리스트 렌더링
          Column(
            children: [
              for (var item in data)
                CategoryBudgetItem(
                  title: item.label,
                  percent: item.percent,
                  amount: _fakeAmount(item.percent),
                  color: item.color,
                ),
            ],
          ),

          const SizedBox(height: 20),

          // 전체보기 버튼
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text(
                "전체보기",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fakeAmount(int percent) {
    // test dummy number
    final amount = percent * 33000;
    return "${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}원";
  }
}

class CategoryData {
  final String label;
  final int percent;
  final Color color;

  CategoryData(this.label, this.percent, this.color);
}

class CategoryBudgetItem extends StatelessWidget {
  final String title;
  final int percent;
  final String amount;
  final Color color;

  const CategoryBudgetItem({
    super.key,
    required this.title,
    required this.percent,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$percent%",
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const Spacer(),
          Text(
            amount,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    );
  }
}