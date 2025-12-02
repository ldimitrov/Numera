import 'package:flutter_test/flutter_test.dart';
import 'package:numera/logic/calculator.dart';

void main() {
  group('Calculator Logic', () {
    final calculator = Calculator();

    test('Basic addition', () {
      expect(calculator.evaluateLine('2 + 2'), '4');
    });

    test('Basic multiplication', () {
      expect(calculator.evaluateLine('3 * 4'), '12');
    });

    test('Decimal result', () {
      expect(calculator.evaluateLine('5 / 2'), '2.5');
    });

    test('Invalid expression returns null', () {
      expect(calculator.evaluateLine('hello world'), null);
    });

    test('Empty line returns null', () {
      expect(calculator.evaluateLine(''), null);
    });

    test('Multiline processing', () {
      const input = '2 + 2\n3 * 3\n\n10 / 2';
      final results = calculator.processText(input);
      expect(results, ['4', '9', null, '5']);
    });

    test('Ignores trailing equals', () {
      expect(calculator.evaluateLine('2 + 2 ='), '4');
    });
  });

  group('Unit Conversions', () {
    final calculator = Calculator();

    test('Time conversion: seconds to minutes', () {
      expect(calculator.evaluateLine('200 seconds in minutes'), '3.3333 minutes');
    });

    test('Length conversion: cm to inches', () {
      final result = calculator.evaluateLine('50 cm in inches');
      expect(result, isNotNull);
      expect(result, contains('inches'));
    });

    test('Length conversion: feet to meters', () {
      final result = calculator.evaluateLine('10 ft in m');
      expect(result, isNotNull);
      expect(result, contains('m'));
    });

    test('Mass conversion: kg to pounds', () {
      final result = calculator.evaluateLine('5 kg in lb');
      expect(result, isNotNull);
      expect(result, contains('lb'));
    });

    test('Temperature conversion: celsius to fahrenheit', () {
      final result = calculator.evaluateLine('100 c in f');
      expect(result, isNotNull);
      expect(result, contains('f'));
    });

    test('Invalid unit conversion returns null', () {
      expect(calculator.evaluateLine('50 invalid in units'), null);
    });

    test('Math still works with unit-like text', () {
      expect(calculator.evaluateLine('2 + 2'), '4');
    });
  });
}
