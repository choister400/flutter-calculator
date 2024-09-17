import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // Package for expression evaluation

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator by [Your Name]',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(title: 'Calculator by Jacob Choi and ChatGPT'),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key, required this.title});

  final String title;

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _expression = '';  // Holds the ongoing input expression
  String _result = '';      // Holds the result of the calculation

  // Function to handle button presses
  void _onButtonPressed(String value) {
    setState(() {
      // Clear the expression and result
      if (value == 'C') {
        _expression = '';
        _result = '';
      } 
      // Evaluate the expression
      else if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();  // Evaluator for parsing
          var evalResult = evaluator.eval(expression, {});
          _result = evalResult.toString();
        } catch (e) {
          _result = 'Error';
        }
      } 
      // Append the button value to the expression
      else {
        _expression += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Display for expression and result
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 24, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Calculator buttons
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', '*']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['%', '0', '=', '+']), // Add the '%' button here
          _buildButtonRow(['C']),
        ],
      ),
    );
  }

  // Helper function to build button rows
  Widget _buildButtonRow(List<String> values) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: values.map((value) => _buildButton(value)).toList(),
      ),
    );
  }

  // Helper function to create individual buttons
  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(value),
          child: Text(
            value,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
