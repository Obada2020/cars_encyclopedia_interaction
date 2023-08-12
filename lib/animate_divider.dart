import 'package:flutter/cupertino.dart';

class AnimatedDivider extends StatefulWidget {
  List<Color> colors;
  AnimatedDivider({Key? key, required this.colors}) : super(key: key);
  @override
  _AnimatedDividerState createState() => _AnimatedDividerState();
}

class _AnimatedDividerState extends State<AnimatedDivider>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  @override
  void initState() {
    super.initState();
  _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!);
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController?.forward();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animation ?? _animationController!,
        builder: (context, child) => Container(
          width: (_animation?.value ?? 0) * 400,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
            ),
          ),
          height: 2,
          child: child,
        ),
        child: const SizedBox.expand(),
      );
}
