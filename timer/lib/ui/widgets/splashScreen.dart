import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:oneteatree/ui/widgets/countdownPage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      animationDuration: Duration(seconds: 1),
      splash: TweenAnimationT(),
      nextScreen: CountdownPage(),
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.decoratedBoxTransition,
      splashIconSize: double.infinity,
    );
  }
}

class TweenAnimationT extends StatefulWidget {
  const TweenAnimationT({super.key});

  @override
  State<TweenAnimationT> createState() => _TweenAnimationTState();
}

class _TweenAnimationTState extends State<TweenAnimationT>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Animatable<Color?> background = TweenSequence<Color?>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Color.fromRGBO(250, 236, 202, 1.0),
        end: Color.fromRGBO(255, 230, 168, 1.0),
      ),
    ),
    TweenSequenceItem(
      tween: ColorTween(
        begin: Color.fromRGBO(255, 230, 168, 1.0),
        end: Color.fromRGBO(102, 58, 14, 1.0),
      ),
      weight: 1.0,
    ),
  ]);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
        animationBehavior: AnimationBehavior.preserve)
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: ((context, child) {
          return Scaffold(
            body: Container(
              color: background
                  .evaluate(AlwaysStoppedAnimation(_controller.value)),
            ),
          );
        }));
  }
}
