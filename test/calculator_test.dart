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

    test('Invalid expression returns null', () {
      expect(calculator.evaluateLine('hello world'), null);
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

    test('Invalid conversion returns null', () {
      expect(calculator.evaluateLine('50 invalid in units'), null);
    });
  });
}
