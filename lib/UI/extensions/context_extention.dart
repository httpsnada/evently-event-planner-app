import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension BuildContextExtention on BuildContext {
  void showMessage(
    String message, {
    String? posActionText,
    VoidCallback? onPosActionClick,
    String? negActionText,
    VoidCallback? onNegActionClick,
    bool isDismissable = true,
  }) {
    showDialog(
      context: this,
      barrierDismissible: isDismissable,
      builder: (context) {
        var actions = [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onPosActionClick?.call();
            },
            child: Text(posActionText ?? "Ok"),
          ),
        ];

        if (negActionText != null) {
          actions.add(
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onNegActionClick?.call();
              },
              child: Text(negActionText),
            ),
          );
        }
        return AlertDialog(
          content: Row(
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: GoogleFonts.inter().fontFamily,
                ),
              ),
            ],
          ),
          actions: actions,
        );
      },
    );
  }

  void showLoadingDialog({String? message, bool isDismissable = true}) {
    showDialog(
      context: this,
      barrierDismissible: isDismissable,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 4),
              Text(
                message ?? "Loading ...",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
