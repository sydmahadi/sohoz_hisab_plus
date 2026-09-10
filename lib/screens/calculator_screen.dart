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
      if (display == '0' || shouldResetDisplay) {
        display = number;
        shouldResetDisplay = false;
      } else {
        display += number;
      }
    });
  }

  void _decimalPressed() {
    setState(() {
      if (shouldResetDisplay) {
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
    bool isOperator = false,
    bool isEqual = false,
    bool isClear = false,
  }) {
    Color backgroundColor;
    Color foregroundColor;

    if (isEqual) {
      backgroundColor = AppTheme.gold;
      foregroundColor = Colors.white;
    } else if (isClear) {
      backgroundColor = const Color(0xFF7A3028);
      foregroundColor = Colors.white;
    } else if (isOperator) {
      backgroundColor = AppTheme.green;
      foregroundColor = Colors.white;
    } else {
      backgroundColor = AppTheme.cardColor;
      foregroundColor = AppTheme.textDark;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 68,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppTheme.gold.withOpacity(0.35),
                  width: 0.6,
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: text == '⌫' ? 24 : 22,
                  fontWeight: FontWeight.bold,
                ),
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
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              // Display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 26,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.darkGreen,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppTheme.gold.withOpacity(0.65),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.darkGreen.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (operator != null)
                      Text(
                        '${_formatResult(firstNumber ?? 0)} $operator',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 15,
                        ),
                      ),

                    const SizedBox(height: 8),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        display,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Calculator buttons
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        _button(
                          text: 'AC',
                          onPressed: _clear,
                          isClear: true,
                        ),
                        _button(
                          text: '⌫',
                          onPressed: _backspace,
                        ),
                        _button(
                          text: '÷',
                          onPressed: () => _operatorPressed('÷'),
                          isOperator: true,
                        ),
                        _button(
                          text: '×',
                          onPressed: () => _operatorPressed('×'),
                          isOperator: true,
                        ),
                      ],
                    ),

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
                          isOperator: true,
                        ),
                      ],
                    ),

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
                          isOperator: true,
                        ),
                      ],
                    ),

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
                          isEqual: true,
                        ),
                      ],
                    ),

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
                        _button(
                          text: '=',
                          onPressed: _calculate,
                          isEqual: true,
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
