import 'package:flutter/material.dart';

class ExpandedTimeline extends StatefulWidget {
  final Widget child;
  final int height;
  final bool expand;

  ExpandedTimeline({this.expand = false, required this.child, required this.height});

  @override
  _ExpandedTimelineState createState() => _ExpandedTimelineState();
}

class _ExpandedTimelineState extends State<ExpandedTimeline>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _prepareAnimations();
    _runExpandCheck();
  }

  // Setting up the animation
  void _prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation,
        child: Container(
          // padding: EdgeInsets.only(bottom: 5),
          constraints: BoxConstraints(
              // minHeight: 100,
              minWidth: double.infinity,
              maxHeight: widget.height.toDouble()),
          child: Padding(padding: const EdgeInsets.only(bottom: 5), child: widget.child),
        ));
  }
}