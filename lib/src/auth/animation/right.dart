import 'package:flutter/material.dart';

class RightAnimation extends StatefulWidget {
  const RightAnimation({Key? key, required this.child, required this.delay})
      : super(key: key);

  final Widget child;
  final double delay;

  @override
  State<RightAnimation> createState() => _RightAnimationState();
}

class _RightAnimationState extends State<RightAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: (500 * widget.delay).round()),
      vsync: this,
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(40, 0.0), // Starts from the Right (off-screen)
      end: Offset.zero,
    ).animate(controller);

    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Transform.translate(
      offset: slideAnimation.value,
      child: Opacity(
        opacity: animation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
