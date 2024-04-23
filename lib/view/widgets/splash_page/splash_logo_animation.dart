import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';

class SplashLogoAnimation extends StatefulWidget {
  final String imagePath;
  final int? durationSecond;
  final double? logoHeightFraction;
  const SplashLogoAnimation(
      {super.key,
      required this.imagePath,
      this.durationSecond,
      this.logoHeightFraction});

  @override
  State<SplashLogoAnimation> createState() => _SplashLogoAnimationState();
}

class _SplashLogoAnimationState extends State<SplashLogoAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: widget.durationSecond ?? 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.ease);
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 4),
        height: AppVars.screenSize.height * (widget.logoHeightFraction ?? 0.06),
        child: Image.asset(widget.imagePath),
      ),
    );
  }
}
