import 'package:flutter/material.dart';
import 'package:salah_app/core/utils/constants.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.onTapOutside,
    required this.text,
    this.maxLength,
    this.enabled = true,
    this.maxLines,
  });

  final TextEditingController? controller;
  final void Function(PointerDownEvent p1)? onTapOutside;
  final String text;
  final int? maxLength;
  final bool enabled;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      onTapOutside: onTapOutside,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: inputDecoration(context, text: text),
    );
  }
}

InputDecoration inputDecoration(
  BuildContext context, {
  String? text,
  bool dense = false,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.surface,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(sm)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.surface,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(sm)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.surface,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(sm)),
    ),
    fillColor: Theme.of(context).colorScheme.secondaryContainer,
    filled: true,
    hintText: text,
    hintStyle: TextStyle(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    ),
  );
}
