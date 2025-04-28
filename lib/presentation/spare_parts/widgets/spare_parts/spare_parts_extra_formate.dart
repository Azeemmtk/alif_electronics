String formatExtra(String category, String? value, {required bool isExtra1}) {
  if (value == null) return 'N/A';
  switch (category) {
    case 'Resistor':
      return isExtra1 ? '$value W' : '±$value%';
    case 'Capacitor':
      return isExtra1 ? '$value µF' : '$value V';
    case 'Transistor':
      return isExtra1 ? '$value V' : '$value mA';
    case 'IC':
      return '$value V';
    default:
      return value; // For custom categories, use raw value unless units are defined
  }
}
