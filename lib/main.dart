import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;
  List<String> _history = []; 

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _operator = "";
        _num1 = 0;
        _num2 = 0;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        _operator = value;
        _num1 = double.tryParse(_input) ?? 0;
        _input = "";
      } else if (value == "=") {
        _num2 = double.tryParse(_input) ?? 0;
        if (_operator == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operator == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operator == "*") {
          _output = (_num1 * _num2).toString();
        } else if (_operator == "/") {
          _output = (_num2 != 0) ? (_num1 / _num2).toString() : "Error";
        }

        if (_operator.isNotEmpty && _num2 != 0) {
          _history.add("$_num1 $_operator $_num2 = $_output");
        }
        _input = _output;
        _operator = "";
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(value),
        child: Text(
          value,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildHistory() {
    return Expanded(
      child: ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _history[index],
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          _buildHistory(), 
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/"),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*"),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: [
                  _buildButton("C"),
                  _buildButton("0"),
                  _buildButton("="),
                  _buildButton("+"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
