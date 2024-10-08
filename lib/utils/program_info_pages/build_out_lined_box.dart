import 'package:flutter/material.dart';

Widget buildOutlinedBox(BuildContext context,
    {required String title, required String content}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.orange, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    ),
  );
}
