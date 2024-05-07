import 'dart:async';

import 'package:flutter/material.dart';

void showMessageDialog({
  required BuildContext context,
  required String text,
}) {
  var opacity = 1.0;

  final overlayEntry = OverlayEntry(
    canSizeOverlay: true,
    builder: (context) {
      return IgnorePointer(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 1),
              child: _MessageDialog(
                text: text,
              ),
            ),
          ),
        ),
      );
    },
  );

  Overlay.of(context).insert(overlayEntry);

  Timer(
    const Duration(seconds: 1),
    () {
      opacity = 0.0;
      overlayEntry.markNeedsBuild();
      Timer(
        const Duration(seconds: 1),
        overlayEntry.remove,
      );
    },
  );
}

class _MessageDialog extends StatelessWidget {
  const _MessageDialog({
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme
            ? Colors.white.withOpacity(0.8)
            : Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isDarkTheme ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
