```dart
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        title: const Text('অ্যাপ সম্পর্কে'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // App icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.darkGreen,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppTheme.gold,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/icon.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.calculate_rounded,
                      color: AppTheme.gold,
                      size: 55,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'সহজ হিসাব+',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'দৈনন্দিন হিসাবকে সহজ করার একটি ছোট্ট অ্যাপ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textMuted,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 28),

            _infoCard(
              icon: Icons.edit_note_rounded,
              title: 'এন্ট্রি',
              description:
                  'প্রয়োজনীয় হিসাব ও তথ্য সহজে সংরক্ষণ ও পরিচালনা করুন।',
            ),

            _infoCard(
              icon: Icons.calculate_rounded,
              title: 'ক্যালকুলেটর',
              description:
                  'দৈনন্দিন প্রয়োজনীয় বিভিন্ন হিসাব দ্রুত সম্পন্ন করুন।',
            ),

            _infoCard(
              icon: Icons.note_alt_rounded,
              title: 'নোট',
              description:
                  'গুরুত্বপূর্ণ তথ্য ও প্রয়োজনীয় নোট সংরক্ষণ করে রাখুন।',
            ),

            _infoCard(
              icon: Icons.calendar_month_rounded,
              title: 'ক্যালেন্ডার',
              description:
                  'তারিখ নির্বাচন করে প্রয়োজনীয় তথ্য সহজে দেখুন।',
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.gold.withOpacity(0.35),
                  width: 0.7,
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    'সহজ হিসাব+',
                    style: TextStyle(
                      color: AppTheme.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 13,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    '© 2026 সহজ হিসাব+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.gold.withOpacity(0.35),
          width: 0.7,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.darkGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppTheme.gold,
              size: 26,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```
