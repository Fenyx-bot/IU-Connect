import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LikeButton extends StatelessWidget {
  bool isLiked = false;
  void Function()? onLike;
  LikeButton({super.key, required this.isLiked, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLike,
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}