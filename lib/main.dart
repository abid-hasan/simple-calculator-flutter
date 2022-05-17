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
        primarySwatch: Colors.teal,
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
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == "⌫") {
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") equation = "0";
      } else if (buttonText == "=") {
        equationFontSize = 38;
        resultFontSize = 48;

        expression = equation;

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          equation = result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48;
        resultFontSize = 38;
        equation == "0" ? equation = buttonText : equation += buttonText;
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
            equation,
            style: TextStyle(fontSize: equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(
            result,
            style: TextStyle(fontSize: resultFontSize),
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
