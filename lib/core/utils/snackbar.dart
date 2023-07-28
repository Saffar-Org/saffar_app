import 'package:flutter/material.dart';

/// Shows [SnackBar] in a customized fasion
class Snackbar {
  const Snackbar._(this._context);

  final BuildContext _context;

  factory Snackbar.of(BuildContext context) {
    return Snackbar._(context);
  }

  /// First clears all existing snackbars and then shows
  /// the current snackbar
  void show(
    String message, {
    bool error = false,
    Color? bgColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(_context).clearSnackBars();
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor:
            bgColor ?? (error ? Theme.of(_context).colorScheme.error : null),
        content: Text(
          message,
          style: textColor != null
              ? TextStyle(color: textColor)
              : error
                  ? TextStyle(
                      color: Theme.of(_context).colorScheme.onError,
                    )
                  : null,
        ),
      ),
    );
  }
}
