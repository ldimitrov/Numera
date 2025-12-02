import 'package:flutter_test/flutter_test.dart';
import 'package:numera/logic/calculator.dart';

void main() {
  group('Calculator - Math Expressions', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('Basic addition', () {
      expect(calculator.evaluateLine('2 + 2'), '4');
    });

    test('Basic subtraction', () {
      expect(calculator.evaluateLine('10 - 3'), '7');
    });

    test('Basic multiplication', () {
      expect(calculator.evaluateLine('3 * 4'), '12');
    });

    test('Basic division', () {
      expect(calculator.evaluateLine('5 / 2'), '2.5');
    });

    test('Complex expression with parentheses', () {
      expect(calculator.evaluateLine('(2 + 3) * 4'), '20');
    });

    test('Expression with decimals', () {
      expect(calculator.evaluateLine('2.5 + 3.7'), '6.2');
    });

    test('Order of operations', () {
      expect(calculator.evaluateLine('2 + 3 * 4'), '14');
    });

    test('Integer result displayed without decimal', () {
      final result = calculator.evaluateLine('10 / 2');
      expect(result, '5');
      expect(result, isNot(contains('.')));
    });

    test('Invalid expression returns error indicator', () {
      expect(calculator.evaluateLine('hello world'), '?');
    });

    test('Empty line returns null', () {
      expect(calculator.evaluateLine(''), null);
    });

    test('Ignores trailing equals', () {
      expect(calculator.evaluateLine('2 + 2 ='), '4');
    });
  });

  group('Calculator - Multiline Processing', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('Processes multiple lines correctly', () {
      const input = '2 + 2\n3 * 3\n\n10 / 2';
      final results = calculator.processText(input);
      expect(results, ['4', '9', null, '5']);
    });

    test('Shows error indicator for incomplete expressions', () {
      const input = '2 +\n5';
      final results = calculator.processText(input);
      expect(results, ['?', '5']);
    });

    test('Handles mix of math and conversions', () {
      const input = '2 + 2\n100 cm in m\n5 * 5';
      final results = calculator.processText(input);
      expect(results[0], '4');
      expect(results[1], contains('m'));
      expect(results[2], '25');
    });
  });

  group('Calculator - Integration with Unit Converter', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('Delegates unit conversions correctly', () {
      expect(calculator.evaluateLine('200 seconds in minutes'), '3.3333 minutes');
    });

    test('Falls back to math when conversion fails', () {
      expect(calculator.evaluateLine('2 + 2'), '4');
    });

    test('Invalid conversion returns error indicator', () {
      expect(calculator.evaluateLine('50 invalid in units'), '?');
    });
  });

  group('Calculator - Variable Assignments', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('Assigns and returns value', () {
      expect(calculator.evaluateLine('x = 10'), '10');
    });

    test('Uses assigned variable in expression', () {
      calculator.evaluateLine('x = 5');
      expect(calculator.evaluateLine('x + 3'), '8');
    });

    test('Assigns expression result to variable', () {
      expect(calculator.evaluateLine('result = 2 + 3'), '5');
    });

    test('Uses multiple variables in expression', () {
      calculator.evaluateLine('a = 10');
      calculator.evaluateLine('b = 20');
      expect(calculator.evaluateLine('c = a + b'), '30');
    });

    test('Variable names can contain underscores', () {
      expect(calculator.evaluateLine('my_var = 42'), '42');
    });

    test('Handles complex expense calculation', () {
      const input = '''power = 200
rent = 1000
water = 100
shopping = 500
expenses = power + rent + water + shopping''';
      final results = calculator.processText(input);
      expect(results, ['200', '1000', '100', '500', '1800']);
    });

    test('Reassigning variable updates value', () {
      calculator.evaluateLine('x = 5');
      expect(calculator.evaluateLine('x'), '5');
      calculator.evaluateLine('x = 10');
      expect(calculator.evaluateLine('x'), '10');
    });

    test('Variable in expression with operators', () {
      calculator.evaluateLine('price = 100');
      expect(calculator.evaluateLine('price * 1.15'), '115');
    });
  });
}
