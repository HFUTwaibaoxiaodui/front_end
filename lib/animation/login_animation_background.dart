import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum _ColorBetween {color1, color2}

class LoginAnimationBackground extends StatelessWidget {
  const LoginAnimationBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_ColorBetween>()
      ..add(_ColorBetween.color1, ColorTween(begin: Colors.blue.shade100, end: Colors.green.shade600), const Duration(seconds: 2))
      ..add(_ColorBetween.color2, ColorTween(end: Colors.yellow.shade100, begin: Colors.blue.shade600), const Duration(seconds: 2));

    return MirrorAnimation<MultiTweenValues<_ColorBetween>>(
      tween: tween,
      duration: tween.duration,
      builder: (context, child, value) {
        return Container(
          width: double.infinity,
          child: const Center(
            child: Text('欢迎', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 36, letterSpacing: 10, color: Colors.white))
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    value.get<Color>(_ColorBetween.color1),
                    value.get<Color>(_ColorBetween.color2)
                  ])),
        );
      },
    );
  }
}