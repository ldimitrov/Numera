import 'package:math_expressions/math_expressions.dart';
import 'unit_converter.dart';
import 'number_formatter.dart';

class Calculator {
  final ShuntingYardParser _parser = ShuntingYardParser();
  final ContextModel _context = ContextModel();
  final UnitConverter _unitConverter = UnitConverter();

  String? evaluateLine(String line) {
    line = line.trim();
    if (line.isEmpty) return null;

    if (line.endsWith('=')) {
      line = line.substring(0, line.length - 1).trim();
    }

    // Try to parse as unit conversion first
    String? conversionResult = _unitConverter.convert(line);
    if (conversionResult != null) {
      return conversionResult;
    }

    // If not a conversion, try to evaluate as math expression
    return _evaluateMathExpression(line);
  }

  String? _evaluateMathExpression(String line) {
    try {
      Expression exp = _parser.parse(line);
      double result = RealEvaluator(_context).evaluate(exp).toDouble();
      return NumberFormatter.format(result);
    } catch (e) {
      return null;
    }
  }

  List<String?> processText(String text) {
    List<String> lines = text.split('\n');
    return lines.map((line) => evaluateLine(line)).toList();
  }
}
