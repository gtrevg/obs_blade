import 'package:flutter/material.dart';

class Fader extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration? showDuration;

  const Fader({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.showDuration,
  }) : super(key: key);

  @override
  _FaderState createState() => _FaderState();
}

class _FaderState extends State<Fader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: this.widget.duration);
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    if (this.widget.showDuration != null) {
      Future.delayed(this.widget.showDuration!, () => _controller.reverse());
    }
    return FadeTransition(
      opacity: _animation,
      child: this.widget.child,
    );
  }
}
