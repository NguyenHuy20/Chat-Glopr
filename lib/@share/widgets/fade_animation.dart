import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {

var tween = MovieTween()
    ..scene(duration: const Duration(milliseconds: 250))
        .tween(AniProps.opacity, Tween<double>(begin: 0.0, end: 1.0))
        .tween(AniProps.translateY, Tween<double>(begin: -25.0, end: 0.0));

  return PlayAnimationBuilder<Movie>(
    tween: tween,
    duration: tween.duration,
    builder: (context, value, _) {
        return Opacity(
          opacity: value.get(AniProps.opacity),
                 child: Transform.translate(
            offset: Offset(0, value.get(AniProps.translateY)),
            child: child
        ),
        );
      },
    );
  }
}

