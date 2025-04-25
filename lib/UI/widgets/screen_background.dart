import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/UI/utils/asset_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  Stack(
            children:[

              SvgPicture.asset(
                AssetsPath.backgroundSvg,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: double.maxFinite,

              ),
              SafeArea(child: child),

            ]);

  }
}
