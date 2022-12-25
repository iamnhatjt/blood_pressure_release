extension StringExtension on String {
  int get toInt {
    final stringNumber = replaceAll(RegExp(r'[^0-9]'), '');
    if (stringNumber.isNotEmpty) {
      return int.parse(stringNumber);
    }
    return 0;
  }

  double get toDouble {
    try {
      return double.parse(this);
    } catch (e) {
      return 0.0;
    }
  }
}
