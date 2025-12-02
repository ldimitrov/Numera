import 'package:math_expressions/math_expressions.dart';
import 'package:units_converter/units_converter.dart';

class Calculator {
  final ShuntingYardParser _parser = ShuntingYardParser();
  final ContextModel _context = ContextModel();

  String? evaluateLine(String line) {
    line = line.trim();
    if (line.isEmpty) return null;

    if (line.endsWith('=')) {
      line = line.substring(0, line.length - 1).trim();
    }

    // Try to parse as unit conversion first
    String? conversionResult = _tryConvertUnits(line);
    if (conversionResult != null) {
      return conversionResult;
    }

    // If not a conversion, try to evaluate as math expression
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

  String? _tryConvertUnits(String line) {
    // Parse patterns like "200 seconds in minutes" or "50 cm in inches"
    final pattern = RegExp(r'^([\d.]+)\s*(\w+)\s+(?:in|to)\s+(\w+)$', caseSensitive: false);
    final match = pattern.firstMatch(line);

    if (match == null) return null;

    try {
      final value = double.parse(match.group(1)!);
      final fromUnit = match.group(2)!.toLowerCase();
      final toUnit = match.group(3)!.toLowerCase();

      // Try different unit categories
      double? result;

      // Length conversions
      result ??= _tryLengthConversion(value, fromUnit, toUnit);

      // Time conversions
      result ??= _tryTimeConversion(value, fromUnit, toUnit);

      // Mass conversions
      result ??= _tryMassConversion(value, fromUnit, toUnit);

      // Temperature conversions
      result ??= _tryTemperatureConversion(value, fromUnit, toUnit);

      // Area conversions
      result ??= _tryAreaConversion(value, fromUnit, toUnit);

      // Volume conversions
      result ??= _tryVolumeConversion(value, fromUnit, toUnit);

      // Speed conversions
      result ??= _trySpeedConversion(value, fromUnit, toUnit);

      if (result != null) {
        if (result % 1 == 0) {
          return '${result.toInt()} $toUnit';
        }
        final formatted = result.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
        return '$formatted $toUnit';
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  double? _tryLengthConversion(double value, String from, String to) {
    final unitMap = {
      'mm': LENGTH.millimeters,
      'millimeter': LENGTH.millimeters,
      'millimeters': LENGTH.millimeters,
      'cm': LENGTH.centimeters,
      'centimeter': LENGTH.centimeters,
      'centimeters': LENGTH.centimeters,
      'm': LENGTH.meters,
      'meter': LENGTH.meters,
      'meters': LENGTH.meters,
      'km': LENGTH.kilometers,
      'kilometer': LENGTH.kilometers,
      'kilometers': LENGTH.kilometers,
      'in': LENGTH.inches,
      'inch': LENGTH.inches,
      'inches': LENGTH.inches,
      'ft': LENGTH.feet,
      'foot': LENGTH.feet,
      'feet': LENGTH.feet,
      'yd': LENGTH.yards,
      'yard': LENGTH.yards,
      'yards': LENGTH.yards,
      'mi': LENGTH.miles,
      'mile': LENGTH.miles,
      'miles': LENGTH.miles,
    };

    if (unitMap.containsKey(from) && unitMap.containsKey(to)) {
      return value.convertFromTo(unitMap[from]!, unitMap[to]!);
    }
    return null;
  }

  double? _tryTimeConversion(double value, String from, String to) {
    final unitMap = {
      'ms': TIME.milliseconds,
      'millisecond': TIME.milliseconds,
      'milliseconds': TIME.milliseconds,
      's': TIME.seconds,
      'sec': TIME.seconds,
      'second': TIME.seconds,
      'seconds': TIME.seconds,
      'min': TIME.minutes,
      'minute': TIME.minutes,
      'minutes': TIME.minutes,
      'h': TIME.hours,
      'hr': TIME.hours,
      'hour': TIME.hours,
      'hours': TIME.hours,
      'd': TIME.days,
      'day': TIME.days,
      'days': TIME.days,
      'week': TIME.weeks,
      'weeks': TIME.weeks,
    };

    if (unitMap.containsKey(from) && unitMap.containsKey(to)) {
      return value.convertFromTo(unitMap[from]!, unitMap[to]!);
    }
    return null;
  }

  double? _tryMassConversion(double value, String from, String to) {
    final unitMap = {
      'mg': MASS.milligrams,
      'milligram': MASS.milligrams,
      'milligrams': MASS.milligrams,
      'g': MASS.grams,
      'gram': MASS.grams,
      'grams': MASS.grams,
      'kg': MASS.kilograms,
      'kilogram': MASS.kilograms,
      'kilograms': MASS.kilograms,
      'oz': MASS.ounces,
      'ounce': MASS.ounces,
      'ounces': MASS.ounces,
      'lb': MASS.pounds,
      'lbs': MASS.pounds,
      'pound': MASS.pounds,
      'pounds': MASS.pounds,
    };

    if (unitMap.containsKey(from) && unitMap.containsKey(to)) {
      return value.convertFromTo(unitMap[from]!, unitMap[to]!);
    }
    return null;
  }

  double? _tryTemperatureConversion(double value, String from, String to) {
    final unitMap = {
      'c': TEMPERATURE.celsius,
      'celsius': TEMPERATURE.celsius,
      'f': TEMPERATURE.fahrenheit,
      'fahrenheit': TEMPERATURE.fahrenheit,
      'k': TEMPERATURE.kelvin,
      'kelvin': TEMPERATURE.kelvin,
    };

    if (unitMap.containsKey(from) && unitMap.containsKey(to)) {
      return value.convertFromTo(unitMap[from]!, unitMap[to]!);
    }
    return null;
  }

  double? _tryAreaConversion(double value, String from, String to) {
    final unitMap = {
      'mm2': AREA.squareMillimeters,
      'cm2': AREA.squareCentimeters,
      'm2': AREA.squareMeters,
      'km2': AREA.squareKilometers,
      'in2': AREA.squareInches,
      'ft2': AREA.squareFeet,
      'mi2': AREA.squareMiles,
      'acre': AREA.acres,
      'acres': AREA.acres,
      'hectare': AREA.hectares,
      'hectares': AREA.hectares,
    };

    if (unitMap.containsKey(from) && unitMap.containsKey(to)) {
      return value.convertFromTo(unitMap[from]!, unitMap[to]!);
    }
    return null;
  }

  double? _tryVolumeConversion(double value, String from, String to) {
    final unitMap = {
      'ml': VOLUME.milliliters,
      'milliliter': VOLUME.milliliters,
      'milliliters': VOLUME.milliliters,
      'l': VOLUME.liters,
      'liter': VOLUME.liters,
      'liters': VOLUME.liters,
      'gal': VOLUME.usGallons,
      'gallon': VOLUME.usGallons,
      'gallons': VOLUME.usGallons,
      'qt': VOLUME.usQuarts,
      'quart': VOLUME.usQuarts,
      'quarts': VOLUME.usQuarts,
      'pt': VOLUME.usPints,
      'pint': VOLUME.usPints,
      'pints': VOLUME.usPints,
      'floz': VOLUME.usFluidOunces,
    };

    if (unitMap.containsKey(from) && unitMap.containsKey(to)) {
      return value.convertFromTo(unitMap[from]!, unitMap[to]!);
    }
    return null;
  }

  double? _trySpeedConversion(double value, String from, String to) {
    final unitMap = {
      'mps': SPEED.metersPerSecond,
      'kph': SPEED.kilometersPerHour,
      'kmh': SPEED.kilometersPerHour,
      'mph': SPEED.milesPerHour,
      'knot': SPEED.knots,
      'knots': SPEED.knots,
    };

    if (unitMap.containsKey(from) && unitMap.containsKey(to)) {
      return value.convertFromTo(unitMap[from]!, unitMap[to]!);
    }
    return null;
  }

  List<String?> processText(String text) {
    List<String> lines = text.split('\n');
    return lines.map((line) => evaluateLine(line)).toList();
  }
}
