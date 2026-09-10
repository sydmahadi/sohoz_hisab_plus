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

  // ─────────────────────────────────────────────
  // Number
  // ─────────────────────────────────────────────

  void _numberPressed(String number) {
    setState(() {
      if (display == '0' ||
          display == 'ভুল' ||
          shouldResetDisplay) {
        display = number;
        shouldResetDisplay = false;
      } else {
        display += number;
      }
    });
  }

  // ─────────────────────────────────────────────
  // Decimal
  // ─────────────────────────────────────────────

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

  // ─────────────────────────────────────────────
  // Operator
  // ─────────────────────────────────────────────

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

  // ─────────────────────────────────────────────
  // Calculate
  // ─────────────────────────────────────────────

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

  // ─────────────────────────────────────────────
  // Format Result
  // ─────────────────────────────────────────────

  String _formatResult(double value) {
    if (value.isNaN || value.isInfinite) {
      return 'ভুল';
    }

    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    String result = value.toStringAsFixed(8);

    result = result.replaceFirst(
      RegExp(r'0+$'),
      '',
    );

    result = result.replaceFirst(
      RegExp(r'\.$'),
      '',
    );

    return result;
  }

  // ─────────────────────────────────────────────
  // Clear
  // ─────────────────────────────────────────────

  void _clear() {
    setState(() {
      display = '0';
      firstNumber = null;
      operator = null;
      shouldResetDisplay = false;
    });
  }

  // ─────────────────────────────────────────────
  // Backspace
  // ─────────────────────────────────────────────

  void _backspace() {
    setState(() {
      if (display == 'ভুল' ||
          display.length <= 1 ||
          shouldResetDisplay) {
        display = '0';
        shouldResetDisplay = false;
        return;
      }

      display = display.substring(
        0,
        display.length - 1,
      );

      if (display.isEmpty || display == '-') {
        display = '0';
      }
    });
  }

  // ─────────────────────────────────────────────
  // Calculator Button
  // ─────────────────────────────────────────────

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
          elevation: 0,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(18),
            splashColor:
                AppTheme.primary.withValues(alpha: 0.12),
            highlightColor:
                AppTheme.primary.withValues(alpha: 0.05),
            child: Container(
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFD9D6CC),
                  width: 0.8,
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color:
                      textColor ?? AppTheme.textDark,
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

  // ─────────────────────────────────────────────
  // Equal Button
  // ─────────────────────────────────────────────

  Widget _equalButton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: AppTheme.gold,
        borderRadius: BorderRadius.circular(18),
        elevation: 0,
        child: InkWell(
          onTap: _calculate,
          borderRadius: BorderRadius.circular(18),
          splashColor:
              Colors.white.withValues(alpha: 0.20),
          highlightColor:
              Colors.white.withValues(alpha: 0.08),
          child: Container(
            height: 143,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.goldLight,
                  AppTheme.gold,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gold.withValues(
                    alpha: 0.20,
                  ),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              '=',
              style: TextStyle(
                color: Color(0xFF17352A),
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Screen
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        title: const Text('ক্যালকুলেটর'),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            14,
            10,
            14,
            14,
          ),
          child: Column(
            children: [

              // ────────────────────────────────
              // Display
              // ────────────────────────────────

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  22,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(24),

                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF0EDE3),
                    ],
                  ),

                  border: Border.all(
                    color: const Color(0xFFD8D5CA),
                    width: 0.8,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.06,
                      ),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  children: [

                    // Current operator
                    SizedBox(
                      height: 22,
                      child: operator != null
                          ? Text(
                              '${_formatResult(firstNumber ?? 0)} $operator',
                              style: TextStyle(
                                color:
                                    AppTheme.primary
                                        .withValues(
                                      alpha: 0.65,
                                    ),
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            )
                          : null,
                    ),

                    const SizedBox(height: 6),

                    // Main display
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment:
                          Alignment.centerRight,
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

              // ────────────────────────────────
              // Calculator Buttons
              // ────────────────────────────────

              Expanded(
                child: Column(
                  children: [

                    // AC | ⌫ | ÷ | ×
                    Row(
                      children: [

                        _button(
                          text: 'AC',
                          onPressed: _clear,
                          backgroundColor:
                              const Color(0xFFF3DFDC),
                          textColor:
                              AppTheme.danger,
                        ),

                        _button(
                          text: '⌫',
                          onPressed: _backspace,
                        ),

                        _button(
                          text: '÷',
                          onPressed: () =>
                              _operatorPressed('÷'),
                          backgroundColor:
                              AppTheme.primary,
                          textColor: Colors.white,
                        ),

                        _button(
                          text: '×',
                          onPressed: () =>
                              _operatorPressed('×'),
                          backgroundColor:
                              AppTheme.primary,
                          textColor: Colors.white,
                        ),
                      ],
                    ),

                    // 7 | 8 | 9 | -
                    Row(
                      children: [

                        _button(
                          text: '7',
                          onPressed: () =>
                              _numberPressed('7'),
                        ),

                        _button(
                          text: '8',
                          onPressed: () =>
                              _numberPressed('8'),
                        ),

                        _button(
                          text: '9',
                          onPressed: () =>
                              _numberPressed('9'),
                        ),

                        _button(
                          text: '-',
                          onPressed: () =>
                              _operatorPressed('-'),
                          backgroundColor:
                              AppTheme.primary,
                          textColor: Colors.white,
                        ),
                      ],
                    ),

                    // 4 | 5 | 6 | +
                    Row(
                      children: [

                        _button(
                          text: '4',
                          onPressed: () =>
                              _numberPressed('4'),
                        ),

                        _button(
                          text: '5',
                          onPressed: () =>
                              _numberPressed('5'),
                        ),

                        _button(
                          text: '6',
                          onPressed: () =>
                              _numberPressed('6'),
                        ),

                        _button(
                          text: '+',
                          onPressed: () =>
                              _operatorPressed('+'),
                          backgroundColor:
                              AppTheme.primary,
                          textColor: Colors.white,
                        ),
                      ],
                    ),

                    // 1 | 2 | 3 | LARGE =
                    Row(
                      children: [

                        _button(
                          text: '1',
                          onPressed: () =>
                              _numberPressed('1'),
                        ),

                        _button(
                          text: '2',
                          onPressed: () =>
                              _numberPressed('2'),
                        ),

                        _button(
                          text: '3',
                          onPressed: () =>
                              _numberPressed('3'),
                        ),

                        // Large equal button
                        Expanded(
                          child: _equalButton(),
                        ),
                      ],
                    ),

                    // 0 | 00 | .
                    Row(
                      children: [

                        _button(
                          text: '0',
                          onPressed: () =>
                              _numberPressed('0'),
                        ),

                        _button(
                          text: '00',
                          onPressed: () =>
                              _numberPressed('00'),
                        ),

                        _button(
                          text: '.',
                          onPressed:
                              _decimalPressed,
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
