import 'package:flutter/material.dart';
import 'package:sarti_mobile/test/domain/entities/msg.dart';

class MyMssgBubble extends StatelessWidget {
  final Msg message;

  const MyMssgBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              style: const TextStyle(color: Colors.white),
              message.text,
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
