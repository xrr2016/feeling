import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double value;

  const StarRating(this.value) : assert(value != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        int _val = (value / 2).floor();

        return Icon(
          index < _val ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }
}
