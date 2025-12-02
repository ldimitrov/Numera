import 'package:units_converter/units_converter.dart';
import 'number_formatter.dart';

class UnitConverter {
  static final _lengthUnits = {
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

  static final _timeUnits = {
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

  static final _massUnits = {
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

  static final _temperatureUnits = {
    'c': TEMPERATURE.celsius,
    'celsius': TEMPERATURE.celsius,
    'f': TEMPERATURE.fahrenheit,
    'fahrenheit': TEMPERATURE.fahrenheit,
    'k': TEMPERATURE.kelvin,
    'kelvin': TEMPERATURE.kelvin,
  };

  static final _areaUnits = {
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

  static final _volumeUnits = {
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

  static final _speedUnits = {
    'mps': SPEED.metersPerSecond,
    'kph': SPEED.kilometersPerHour,
    'kmh': SPEED.kilometersPerHour,
    'mph': SPEED.milesPerHour,
    'knot': SPEED.knots,
    'knots': SPEED.knots,
  };

  String? convert(String line) {
    final pattern = RegExp(
      r'^([\d.]+)\s*(\w+)\s+(?:in|to)\s+(\w+)$',
      caseSensitive: false,
    );
    final match = pattern.firstMatch(line);

    if (match == null) return null;

    try {
      final value = double.parse(match.group(1)!);
      final fromUnit = match.group(2)!.toLowerCase();
      final toUnit = match.group(3)!.toLowerCase();

      final result = _tryConvert(value, fromUnit, toUnit);

      if (result != null) {
        return _formatResult(result, toUnit);
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  double? _tryConvert(double value, String from, String to) {
    return _tryConvertCategory(value, from, to, _lengthUnits) ??
        _tryConvertCategory(value, from, to, _timeUnits) ??
        _tryConvertCategory(value, from, to, _massUnits) ??
        _tryConvertCategory(value, from, to, _temperatureUnits) ??
        _tryConvertCategory(value, from, to, _areaUnits) ??
        _tryConvertCategory(value, from, to, _volumeUnits) ??
        _tryConvertCategory(value, from, to, _speedUnits);
  }

  double? _tryConvertCategory(
    double value,
    String from,
    String to,
    Map<String, dynamic> unitMap,
  ) {
    if (unitMap.containsKey(from) && unitMap.containsKey(to)) {
      return value.convertFromTo(unitMap[from]!, unitMap[to]!);
    }
    return null;
  }

  String _formatResult(double result, String unit) {
    return NumberFormatter.format(result, unit: unit);
  }
}