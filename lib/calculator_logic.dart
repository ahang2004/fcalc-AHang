import 'package:expressions/expressions.dart';
import 'dart:math'; // Add this import

class CalculatorLogic {
  String _expression = '';
  String _result = '';
  bool _hasResult = false;

  String get expression => _expression;
  String get result => _result;
  bool get hasResult => _hasResult;

  void input(String value) {
    if (_hasResult && value != '=') {
      // Start new expression after result
      _expression = '';
      _hasResult = false;
    }
    if (value == '=') {
      evaluate();
    } else {
      _expression += value;
      _result = '';
    }
  }

  void clear() {
    _expression = '';
    _result = '';
    _hasResult = false;
  }

  void evaluate() {
    try {
      // Replace operators and sqrt symbol
      String parsed = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAllMapped(RegExp(r'√(\d+(\.\d+)?)'), (match) => 'sqrt(${match[1]})');

      final exp = Expression.parse(parsed);
      final evaluator = const ExpressionEvaluator();
      final evalResult = evaluator.eval(exp, {
        'sqrt': (num x) => sqrt(x), // Provide sqrt function
      });
      _result = evalResult.toString();
      _expression += ' = $_result';
      _hasResult = true;
    } catch (e) {
      _result = 'Error';
      _hasResult = true;
    }
  }
}