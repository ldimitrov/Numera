class NumberFormatter {
  static const int _decimalPrecision = 4;

  static String format(double value, {String? unit}) {
    final formattedNumber = _formatNumber(value);

    if (unit != null) {
      return '$formattedNumber $unit';
    }

    return formattedNumber;
  }

  static String _formatNumber(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }

    return value
        .toStringAsFixed(_decimalPrecision)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }
}