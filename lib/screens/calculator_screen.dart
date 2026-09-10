import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  double? firstNumber;
  String? operator;
  bool shouldResetDisplay = false;

  void _numberPressed(String number) {
    setState(() {
      if (display == '0' || display == 'ভুল' || shouldResetDisplay) {
        display = number;
        shouldResetDisplay = false;
      } else {
        display += number;
      }
    });
  }

  void _decimalPressed() {
    setState(() {
      if (display == 'ভুল' || shouldResetDisplay) {
        display = '0.';
        shouldResetDisplay = false;
        return;
      }

      if (!display.contains('.')) {
        display += '.';
      }
    });
  }

  void _operatorPressed(String selectedOperator) {
    final currentNumber = double.tryParse(display);

    if (currentNumber == null) return;

    if (firstNumber != null && operator != null) {
      _calculate();
    } else {
      firstNumber = currentNumber;
    }

    setState(() {
      operator = selectedOperator;
      shouldResetDisplay = true;
    });
  }

  void _calculate() {
    final secondNumber = double.tryParse(display);

    if (firstNumber == null ||
        operator == null ||
        secondNumber == null) {
      return;
    }

    double result;

    switch (operator) {
      case '+':
        result = firstNumber! + secondNumber;
        break;

      case '-':
        result = firstNumber! - secondNumber;
        break;

      case '×':
        result = firstNumber! * secondNumber;
        break;

      case '÷':
        if (secondNumber == 0) {
          setState(() {
            display = 'ভুল';
            firstNumber = null;
            operator = null;
            shouldResetDisplay = true;
          });
          return;
        }

        result = firstNumber! / secondNumber;
        break;

      default:
        return;
    }

    setState(() {
      display = _formatResult(result);
      firstNumber = result;
      operator = null;
      shouldResetDisplay = true;
    });
  }

  String _formatResult(double value) {
    if (value.isNaN || value.isInfinite) {
      return 'ভুল';
    }

    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    String result = value.toStringAsFixed(8);

    result = result.replaceFirst(RegExp(r'0+$'), '');
    result = result.replaceFirst(RegExp(r'\.$'), '');

    return result;
  }

  void _clear() {
    setState(() {
      display = '0';
      firstNumber = null;
      operator = null;
      shouldResetDisplay = false;
    });
  }

  void _backspace() {
    setState(() {
      if (display == 'ভুল' ||
          display.length <= 1 ||
          shouldResetDisplay) {
        display = '0';
        shouldResetDisplay = false;
        return;
      }

      display = display.substring(0, display.length - 1);

      if (display.isEmpty || display == '-') {
        display = '0';
      }
    });
  }

  Widget _button({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    double height = 68,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Material(
          color: backgroundColor ?? AppTheme.cardColor,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(18),
            splashColor: AppTheme.gold.withValues(alpha: 0.15),
            highlightColor: AppTheme.gold.withValues(alpha: 0.06),
            child: Container(
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppTheme.gold.withValues(alpha: 0.20),
                  width: 0.6,
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? AppTheme.textDark,
                  fontSize: text == '⌫' ? 24 : 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _equalButton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: AppTheme.gold,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: _calculate,
          borderRadius: BorderRadius.circular(18),
          splashColor: Colors.white.withValues(alpha: 0.18),
          child: Container(
            width: double.infinity,
            height: 68,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.goldLight,
                  AppTheme.gold,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gold.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              '=',
              style: TextStyle(
                color: Color(0xFF07140F),
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('ক্যালকুলেটর'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
          child: Column(
            children: [
              // Display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  22,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.cardLight,
                      AppTheme.cardColor,
                    ],
                  ),
                  border: Border.all(
                    color: AppTheme.gold.withValues(alpha: 0.30),
                    width: 0.7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.20),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 22,
                      child: operator != null
                          ? Text(
                              '${_formatResult(firstNumber ?? 0)} $operator',
                              style: TextStyle(
                                color: AppTheme.goldLight
                                    .withValues(alpha: 0.70),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        display,
                        maxLines: 1,
                        style: const TextStyle(
                          color: AppTheme.textDark,
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Calculator
              Expanded(
                child: Column(
                  children: [
                    // AC | Backspace | Divide | Multiply
                    Row(
                      children: [
                        _button(
                          text: 'AC',
                          onPressed: _clear,
                          backgroundColor: const Color(0xFF6D302A),
                          textColor: Colors.white,
                        ),
                        _button(
                          text: '⌫',
                          onPressed: _backspace,
                        ),
                        _button(
                          text: '÷',
                          onPressed: () => _operatorPressed('÷'),
                          backgroundColor: AppTheme.primaryLight,
                          textColor: Colors.white,
                        ),
                        _button(
                          text: '×',
                          onPressed: () => _operatorPressed('×'),
                          backgroundColor: AppTheme.primaryLight,
                          textColor: Colors.white,
                        ),
                      ],
                    ),

                    // 7 | 8 | 9 | -
                    Row(
                      children: [
                        _button(
                          text: '7',
                          onPressed: () => _numberPressed('7'),
                        ),
                        _button(
                          text: '8',
                          onPressed: () => _numberPressed('8'),
                        ),
                        _button(
                          text: '9',
                          onPressed: () => _numberPressed('9'),
                        ),
                        _button(
                          text: '-',
                          onPressed: () => _operatorPressed('-'),
                          backgroundColor: AppTheme.primaryLight,
                          textColor: Colors.white,
                        ),
                      ],
                    ),

                    // 4 | 5 | 6 | +
                    Row(
                      children: [
                        _button(
                          text: '4',
                          onPressed: () => _numberPressed('4'),
                        ),
                        _button(
                          text: '5',
                          onPressed: () => _numberPressed('5'),
                        ),
                        _button(
                          text: '6',
                          onPressed: () => _numberPressed('6'),
                        ),
                        _button(
                          text: '+',
                          onPressed: () => _operatorPressed('+'),
                          backgroundColor: AppTheme.primaryLight,
                          textColor: Colors.white,
                        ),
                      ],
                    ),

                    // 1 | 2 | 3 | =
                    Row(
                      children: [
                        _button(
                          text: '1',
                          onPressed: () => _numberPressed('1'),
                        ),
                        _button(
                          text: '2',
                          onPressed: () => _numberPressed('2'),
                        ),
                        _button(
                          text: '3',
                          onPressed: () => _numberPressed('3'),
                        ),
                        _button(
                          text: '=',
                          onPressed: _calculate,
                          backgroundColor: AppTheme.gold,
                          textColor: const Color(0xFF07140F),
                          height: 143,
                        ),
                      ],
                    ),

                    // 0 | 00 | .
                    Row(
                      children: [
                        _button(
                          text: '0',
                          onPressed: () => _numberPressed('0'),
                        ),
                        _button(
                          text: '00',
                          onPressed: () => _numberPressed('00'),
                        ),
                        _button(
                          text: '.',
                          onPressed: _decimalPressed,
                        ),

                        // Empty space under =
                        const Expanded(
                          child: SizedBox(
                            height: 68,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
