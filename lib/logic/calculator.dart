import 'package:math_expressions/math_expressions.dart';

class Calculator {
  final ShuntingYardParser _parser = ShuntingYardParser();
  final ContextModel _context = ContextModel();

  String? evaluateLine(String line) {
    line = line.trim();
    if (line.isEmpty) return null;

    if (line.endsWith('=')) {
      line = line.substring(0, line.length - 1).trim();
    }

    try {
      Expression exp = _parser.parse(line);
      double result = RealEvaluator(_context).evaluate(exp).toDouble();

      if (result % 1 == 0) {
        return result.toInt().toString();
      }
      return result.toString();
    } catch (e) {
      return null;
    }
  }

  List<String?> processText(String text) {
    List<String> lines = text.split('\n');
    return lines.map((line) => evaluateLine(line)).toList();
  }
}
