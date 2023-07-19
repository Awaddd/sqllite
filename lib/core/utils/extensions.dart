import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  static TextStyle errorStyle = const TextStyle(color: Color(0xFFFF461C));

  void showNotification({
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: isError ? errorStyle : null,
        ),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ),
    );
  }

  void showErrorNotification({
    required String message,
  }) {
    showNotification(message: message, isError: true);
  }
}

extension StringCasingExtension on String {
  String capitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}
