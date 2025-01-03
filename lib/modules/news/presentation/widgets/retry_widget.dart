import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
    required this.onRetry,
    this.label,
  });

  final void Function()? onRetry;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          GestureDetector(
            onTap: onRetry,
            child: Icon(
              Icons.refresh,
              size: 60,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Text(
            label ?? "Something went wrong. Try again",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
