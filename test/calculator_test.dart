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
}
