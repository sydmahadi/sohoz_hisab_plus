import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'entry_screen.dart';
import 'info_screen.dart';
import 'note_screen.dart';
import 'calculator_screen.dart';
import 'calendar_screen.dart';
import 'date_calculator_screen.dart';
import 'time_sum_screen.dart';
import 'daily_average_screen.dart';
import 'monthly_average_screen.dart';
import 'browser_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_MenuItem> items = [
      _MenuItem(
        title: 'এন্ট্রি করুন',
        icon: Icons.edit_note_rounded,
        screen: const EntryScreen(),
      ),
      _MenuItem(
        title: 'তথ্য দেখুন',
        icon: Icons.menu_book_rounded,
        screen: const InfoScreen(),
      ),
      _MenuItem(
        title: 'নোট করুন',
        icon: Icons.note_alt_rounded,
        screen: const NoteScreen(),
      ),
      _MenuItem(
        title: 'ক্যালকুলেটর',
        icon: Icons.calculate_rounded,
        screen: const CalculatorScreen(),
      ),
      _MenuItem(
        title: 'ক্যালেন্ডার',
        icon: Icons.calendar_month_rounded,
        screen: const CalendarScreen(),
      ),
      _MenuItem(
        title: 'তারিখ হিসাব',
        icon: Icons.event_rounded,
        screen: const DateCalculatorScreen(),
      ),
      _MenuItem(
        title: 'সময় যোগ',
        icon: Icons.access_time_rounded,
        screen: const TimeSumScreen(),
      ),
      _MenuItem(
        title: 'দৈনিক গড়',
        icon: Icons.bar_chart_rounded,
        screen: const DailyAverageScreen(),
      ),
      _MenuItem(
        title: 'মাসিক গড়',
        icon: Icons.analytics_rounded,
        screen: const MonthlyAverageScreen(),
      ),
      _MenuItem(
        title: 'ব্রাউজার',
        icon: Icons.language_rounded,
        screen: const BrowserScreen(),
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('সহজ হিসাব প্লাস'),
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: _IslamicBackground(),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                children: [
                  const _HeaderCard(),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'হিসাব ও প্রয়োজনীয় টুল',
                      style: TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.90,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return _MenuCard(
                        item: item,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => item.screen,
                            ),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 26),

                  const _BottomInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Widget screen;

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.screen,
  });
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: AppTheme.darkGreen,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppTheme.gold.withOpacity(0.65),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkGreen.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.gold,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'সহজ হিসাব প্লাস',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'সহজে হিসাব করুন',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'হিসাব, নোট, ক্যালেন্ডার ও প্রয়োজনীয় টুল এক জায়গায়',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.72),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final _MenuItem item;
  final VoidCallback onTap;

  const _MenuCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.cardColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.gold.withOpacity(0.45),
              width: 0.7,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.darkGreen,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.gold.withOpacity(0.7),
                  ),
                ),
                child: Icon(
                  item.icon,
                  color: AppTheme.goldLight,
                  size: 25,
                ),
              ),

              const SizedBox(height: 9),

              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomInfo extends StatelessWidget {
  const _BottomInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 1,
          color: AppTheme.gold.withOpacity(0.6),
        ),

        const SizedBox(height: 12),

        const Text(
          'Developed by Talpatar Sepai',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.textDark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          'm.talpatarsepai@gmail.com',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _IslamicBackground extends StatelessWidget {
  const _IslamicBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _IslamicPatternPainter(),
    );
  }
}

class _IslamicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.darkGreen.withOpacity(0.035)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const spacing = 90.0;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        final center = Offset(x, y);

        final path = Path();

        for (int i = 0; i < 8; i++) {
          final angle = (pi / 4) * i;
          final point = Offset(
            center.dx + cos(angle) * 27,
            center.dy + sin(angle) * 27,
          );

          if (i == 0) {
            path.moveTo(point.dx, point.dy);
          } else {
            path.lineTo(point.dx, point.dy);
          }
        }

        path.close();
        canvas.drawPath(path, paint);

        final innerPaint = Paint()
          ..color = AppTheme.gold.withOpacity(0.025)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        canvas.drawCircle(center, 12, innerPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
