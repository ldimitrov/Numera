import 'package:flutter_test/flutter_test.dart';
import 'package:numera/logic/unit_converter.dart';

void main() {
  group('UnitConverter', () {
    late UnitConverter converter;

    setUp(() {
      converter = UnitConverter();
    });

    group('Length conversions', () {
      test('cm to inches', () {
        final result = converter.convert('50 cm in inches');
        expect(result, isNotNull);
        expect(result, contains('inches'));
        expect(result, contains('19.685'));
      });

      test('feet to meters', () {
        final result = converter.convert('10 ft in m');
        expect(result, isNotNull);
        expect(result, contains('m'));
      });

      test('meters to feet', () {
        final result = converter.convert('100 m to ft');
        expect(result, isNotNull);
        expect(result, contains('ft'));
      });
    });

    group('Time conversions', () {
      test('seconds to minutes', () {
        expect(converter.convert('200 seconds in minutes'), '3.3333 minutes');
      });

      test('hours to seconds', () {
        expect(converter.convert('2 h in s'), '7200 s');
      });

      test('days to hours', () {
        expect(converter.convert('1 d to h'), '24 h');
      });
    });

    group('Mass conversions', () {
      test('kg to pounds', () {
        final result = converter.convert('5 kg in lb');
        expect(result, isNotNull);
        expect(result, contains('lb'));
      });

      test('grams to ounces', () {
        final result = converter.convert('100 g to oz');
        expect(result, isNotNull);
        expect(result, contains('oz'));
      });
    });

    group('Temperature conversions', () {
      test('celsius to fahrenheit', () {
        final result = converter.convert('100 c in f');
        expect(result, isNotNull);
        expect(result, contains('f'));
        expect(result, contains('212'));
      });

      test('fahrenheit to celsius', () {
        final result = converter.convert('32 f to c');
        expect(result, isNotNull);
        expect(result, contains('c'));
        expect(result, contains('0'));
      });
    });

    group('Volume conversions', () {
      test('liters to gallons', () {
        final result = converter.convert('10 l in gal');
        expect(result, isNotNull);
        expect(result, contains('gal'));
      });

      test('milliliters to liters', () {
        expect(converter.convert('1000 ml to l'), '1 l');
      });
    });

    group('Speed conversions', () {
      test('mph to kph', () {
        final result = converter.convert('60 mph in kph');
        expect(result, isNotNull);
        expect(result, contains('kph'));
      });
    });

    group('Edge cases', () {
      test('invalid unit returns null', () {
        expect(converter.convert('50 invalid in units'), null);
      });

      test('non-conversion string returns null', () {
        expect(converter.convert('2 + 2'), null);
      });

      test('empty string returns null', () {
        expect(converter.convert(''), null);
      });

      test('case insensitive - using "IN" instead of "in"', () {
        final result = converter.convert('100 cm IN m');
        expect(result, isNotNull);
        expect(result, contains('m'));
      });

      test('case insensitive - using "TO" instead of "to"', () {
        final result = converter.convert('5 kg TO lb');
        expect(result, isNotNull);
        expect(result, contains('lb'));
      });
    });
  });
}