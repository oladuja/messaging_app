import 'package:flutter/material.dart';

void showDialogAndClose(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('close'),
        ),
      ],
      content: const Text('Account successfully created, you can now login'),
    ),
  );
}