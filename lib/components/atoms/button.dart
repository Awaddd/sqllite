import 'package:flutter/material.dart';
import 'package:salah_app/core/utils/constants.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.color,
    this.icon,
  });

  final String text;
  final void Function() onPressed;
  final bool isDisabled;
  final Color? color;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return FilledButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: icon!,
        label: Text(text),
        style: FilledButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size.fromHeight(50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(sm)),
          ),
        ),
      );
    }

    return FilledButton(
      onPressed: isDisabled ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size.fromHeight(50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(sm)),
        ),
      ),
      child: Text(text),
    );
  }
}
