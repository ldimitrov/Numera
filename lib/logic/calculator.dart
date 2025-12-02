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

    String? conversionResult = _unitConverter.convert(line);
    if (conversionResult != null) {
      return conversionResult;
    }

    if (_isAssignment(line)) {
      return _handleAssignment(line);
    }

    return _evaluateMathExpression(line);
  }

  bool _isAssignment(String line) {
    // Check if line contains '=' and has a valid variable name on the left
    final assignmentPattern = RegExp(r'^([a-zA-Z_]\w*)\s*=\s*(.+)$');
    return assignmentPattern.hasMatch(line);
  }

  String? _handleAssignment(String line) {
    final assignmentPattern = RegExp(r'^([a-zA-Z_]\w*)\s*=\s*(.+)$');
    final match = assignmentPattern.firstMatch(line);

    if (match == null) return '?';

    try {
      final variableName = match.group(1)!;
      final expression = match.group(2)!;

      Expression exp = _parser.parse(expression);
      double result = RealEvaluator(_context).evaluate(exp).toDouble();

      // Store the variable in context
      _context.bindVariable(Variable(variableName), Number(result));

      return NumberFormatter.format(result);
    } catch (e) {
      return '?';
    }
  }

  String? _evaluateMathExpression(String line) {
    try {
      Expression exp = _parser.parse(line);
      double result = RealEvaluator(_context).evaluate(exp).toDouble();
      return NumberFormatter.format(result);
    } catch (e) {
      return '?';
    }
  }

  List<String?> processText(String text) {
    List<String> lines = text.split('\n');
    return lines.map((line) => evaluateLine(line)).toList();
  }
}
