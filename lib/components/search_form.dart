import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchForm extends HookConsumerWidget {
  const SearchForm({
    required this.hintText,
    required this.controller,
    this.onPressed,
    super.key,
  });
  final String hintText;
  final TextEditingController controller;
  final FutureOr<void> Function()? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: IconButton(
          icon: isLoading.value
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                )
              : const Icon(Icons.search),
          onPressed: onPressed == null
              ? null
              : () async {
                  isLoading.value = true;
                  await onPressed!();
                  isLoading.value = false;
                },
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: isLoading.value
              ? null
              : () {
                  controller.clear();
                },
        ),
      ),
      controller: controller,
      enabled: !isLoading.value,
      textInputAction: TextInputAction.search,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: onPressed == null
          ? null
          : (_) async {
              isLoading.value = true;
              await onPressed!();
              isLoading.value = false;
            },
    );
  }
}
