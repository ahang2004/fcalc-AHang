import 'package:flutter/material.dart';
import 'calculator_logic.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _logic = CalculatorLogic();

  final List<List<String>> _buttons = [
    ['7', '8', '9', '÷'],
    ['4', '5', '6', '×'],
    ['1', '2', '3', '-'],
    ['0', '.', 'C', '+'],
    ['√','='],
  ];

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _logic.clear();
      } else {
        _logic.input(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              color: Colors.deepPurple,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'GitHub Copilot',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _logic.expression,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  if (_logic.result.isNotEmpty && !_logic.hasResult)
                    Text(
                      _logic.result,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.right,
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buttons.map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: row.map((btn) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _getButtonColor(btn),
                                foregroundColor: _getTextColor(btn),
                                padding: const EdgeInsets.symmetric(vertical: 22),
                                textStyle: const TextStyle(fontSize: 22),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => _onButtonPressed(btn),
                              child: Text(btn),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(String value) {
    if (value == 'C') return Colors.redAccent;
    if (value == '=') return Colors.deepPurple;
    if (value == '√') return Colors.teal; // Color for sqrt button
    if ('÷×-+'.contains(value)) return Colors.deepPurple[200]!;
    return Colors.white;
  }

  Color _getTextColor(String value) {
    if (value == 'C' || value == '=' || value == '√') return Colors.white;
    if ('÷×-+'.contains(value)) return Colors.deepPurple[900]!;
    return Colors.black87;
  }
}