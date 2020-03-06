import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AssetLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.asset(
      'assets/images/logo_trans.png',
      width: 32.0,
      height: 32.0,
    );
  }
}
