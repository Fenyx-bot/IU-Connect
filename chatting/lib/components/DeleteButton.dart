import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onDelete;
  const DeleteButton({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDelete,
      child: const Icon(Icons.cancel, color: Colors.grey,),
    );
  }
}