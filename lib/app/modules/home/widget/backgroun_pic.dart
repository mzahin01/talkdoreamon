import 'package:flutter/material.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        ImageAsset.background6,
        fit: BoxFit.cover, // or BoxFit.fill
      ),
    );
  }
}
