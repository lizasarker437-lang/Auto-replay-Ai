import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _input = "";
  String _output = "0";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _input = "";
        _output = "0";
      } else if (buttonText == "⌫") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
        if (_input.isEmpty) {
          _output = "0";
        }
      } else if (buttonText == "=") {
        try {
          _output = _evaluateExpression(_input);
        } catch (e) {
          _output = "Error";
        }
      } else {
        if (_input == "0") {
          _input = buttonText;
        } else {
          _input += buttonText;
        }
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      String finalExpression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }

  Widget _buildButton(String text, Color textColor, Color bgColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: textColor,
            padding: const EdgeInsets.all(22.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          onPressed: () => _buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('স্মার্ট ক্যালকুলেটর'),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _input,
                    style: const TextStyle(fontSize: 32, color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _output,
                    style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.grey),
          Column(
            children: [
              Row(children: [_buildButton("C", Colors.red, Colors.grey[850]!), _buildButton("(", Colors.green, Colors.grey[850]!), _buildButton(")", Colors.green, Colors.grey[850]!), _buildButton("÷", Colors.orange, Colors.grey[850]!)]),
              Row(children: [_buildButton("7", Colors.white, Colors.grey[900]!), _buildButton("8", Colors.white, Colors.grey[900]!), _buildButton("9", Colors.white, Colors.grey[900]!), _buildButton("×", Colors.orange, Colors.grey[850]!)]),
              Row(children: [_buildButton("4", Colors.white, Colors.grey[900]!), _buildButton("5", Colors.white, Colors.grey[900]!), _buildButton("6", Colors.white, Colors.grey[900]!), _buildButton("-", Colors.orange, Colors.grey[850]!)]),
              Row(children: [_buildButton("1", Colors.white, Colors.grey[900]!), _buildButton("2", Colors.white, Colors.grey[900]!), _buildButton("3", Colors.white, Colors.grey[900]!), _buildButton("+", Colors.orange, Colors.grey[850]!)]),
              Row(children: [_buildButton("0", Colors.white, Colors.grey[900]!), _buildButton(".", Colors.white, Colors.grey[900]!), _buildButton("⌫", Colors.redAccent, Colors.grey[850]!), _buildButton("=", Colors.white, Colors.orange)}),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
