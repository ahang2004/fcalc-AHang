import 'package:expressions/expressions.dart';

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
      final exp = Expression.parse(_expression.replaceAll('×', '*').replaceAll('÷', '/'));
      final evaluator = const ExpressionEvaluator();
      final evalResult = evaluator.eval(exp, {});
      _result = evalResult.toString();
      _expression += ' = $_result';
      _hasResult = true;
    } catch (e) {
      _result = 'Error';
      _hasResult = true;
    }
  }
}