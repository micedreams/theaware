extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String splitCamelCaseToString() {
    return split(RegExp(r'(?=[A-Z])')).map((p) {
      return p[0].toUpperCase() + p.substring(1);
    }).join(' ');
  }
}
