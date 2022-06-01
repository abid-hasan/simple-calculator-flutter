import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Calculator",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String _equation = "0";
  String _result = "0";
  String _expression = "";
  double _equationFontSize = 38;
  double _resultFontSize = 48;
  bool _isEqualPressed = false;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        _isEqualPressed = false;
        _equation = "0";
        _result = "0";
        _equationFontSize = 38;
        _resultFontSize = 48;
      } else if (buttonText == "⌫") {
        if (_result == "Error") return;

        _isEqualPressed = false;
        _equationFontSize = 48;
        _resultFontSize = 38;
        _equation = _equation.substring(0, _equation.length - 1);
        if (_equation == "") _equation = "0";
      } else if (buttonText == "=") {
        _isEqualPressed = true;

        _equationFontSize = 38;
        _resultFontSize = 48;

        _expression = _equation;

        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);

          ContextModel cm = ContextModel();
          _result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          _result = "Error";
        }
      } else {
        if (_result == "Error") return;

        if (_isEqualPressed) {
          _equation = _result;
          _isEqualPressed = false;
        }

        _equationFontSize = 48;
        _resultFontSize = 38;
        _equation == "0" ? _equation = buttonText : _equation += buttonText;
      }
    });
  }

  Widget _buildButton(
    String buttonText,
    double buttonHeight,
    Color buttonColor,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      color: buttonColor,
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            _equation,
            style: TextStyle(fontSize: _equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(
            _result,
            style: TextStyle(fontSize: _resultFontSize),
          ),
        ),
        Expanded(child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      _buildButton("AC", 1, Colors.redAccent),
                      _buildButton("⌫", 1, Theme.of(context).primaryColor),
                      _buildButton("/", 1, Theme.of(context).primaryColor),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton("7", 1, Colors.black54),
                      _buildButton("8", 1, Colors.black54),
                      _buildButton("9", 1, Colors.black54),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton("4", 1, Colors.black54),
                      _buildButton("5", 1, Colors.black54),
                      _buildButton("6", 1, Colors.black54),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton("1", 1, Colors.black54),
                      _buildButton("2", 1, Colors.black54),
                      _buildButton("3", 1, Colors.black54),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton(".", 1, Colors.black54),
                      _buildButton("0", 1, Colors.black54),
                      _buildButton("00", 1, Colors.black54),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      _buildButton("*", 1, Theme.of(context).primaryColor),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton("-", 1, Theme.of(context).primaryColor),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton("+", 1, Theme.of(context).primaryColor),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildButton("=", 2, Colors.purple),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
