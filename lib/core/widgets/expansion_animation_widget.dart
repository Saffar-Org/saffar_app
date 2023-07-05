import 'package:flutter/material.dart';

/// Expands and Contracts the child widget in a animated way
/// curve defaults to Curves.easeInOut and initiallyExpanded 
/// defaults to true.
class ExpansionAnimationWidget extends StatefulWidget {
  const ExpansionAnimationWidget({
    Key? key,
    required this.controller,
    this.curve = Curves.easeInOut,
    this.initiallyExpanded = true,
    required this.child,
  }) : super(key: key);

  final AnimationController controller;
  final Curve curve;
  final bool initiallyExpanded;
  final Widget child;

  @override
  State<ExpansionAnimationWidget> createState() =>
      _ExpansionAnimationWidgetState();
}

class _ExpansionAnimationWidgetState extends State<ExpansionAnimationWidget> {
  late final Animation _heightFactor;

  @override
  void initState() {
    super.initState();

    _heightFactor = Tween<double>(
      begin: widget.initiallyExpanded ? 1 : 0,
      end: widget.initiallyExpanded ? 0 : 1,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: widget.curve,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return ClipRRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
