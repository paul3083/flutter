import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String expression = '';
  String result = '';

  void addToExpression(String value) {
    setState(() {
      expression += value;
    });
  }

  void calculateResult() {
    setState(() {
      try {
        result = evaluateExpression();
      } catch (e) {
        result = 'Error';
      }
    });
  }

  String evaluateExpression() {
    String evaluatedResult;
    try {
      evaluatedResult = Parser().evaluate(expression).toString();
    } catch (e) {
      evaluatedResult = 'Error';
    }
    return evaluatedResult;
  }

  void reset() {
    setState(() {
      expression = '';
      result = '';
    });
  }

  void deleteDigit() {
    setState(() {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    });
  }

  Widget buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => addToExpression(value),
        child: Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  expression,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('/'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('*'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('-'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('0'),
                ElevatedButton(
                  onPressed: deleteDigit,
                  child: const Text(
                    'Del',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                buildButton('+'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: calculateResult,
                  child: const Text(
                    '=',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: reset,
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Parser {
  double evaluate(String expression) {
    final parsedExpression = Expression(expression);
    return parsedExpression.evaluate();
  }
}

class Expression {
  final String expression;

  Expression(this.expression);

  double evaluate() {
    final cleanExpression = expression.replaceAll(' ', ''); // 공백 제거
    final operands = cleanExpression.split(RegExp(r'[-+*/]')); // 연산자를 기준으로 피연산자 분리
    final operators = cleanExpression.split(RegExp(r'[0-9.]+'));

    double result = double.parse(operands[0]);
    for (var i = 1; i < operands.length; i++) {
      final operator = operators[i];
      final operand = double.parse(operands[i]);

      if (operator == '+') {
        result += operand;
      } else if (operator == '-') {
        result -= operand;
      } else if (operator == '*') {
        result *= operand;
      } else if (operator == '/') {
        result /= operand;
      }
    }

    return result;
  }
}

