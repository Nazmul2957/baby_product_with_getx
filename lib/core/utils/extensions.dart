// lib/core/utils/extensions.dart

extension StringExtensions on String {

  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension IntExtensions on int {

  bool get isZero => this == 0;
}