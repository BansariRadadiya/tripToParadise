import 'package:flutter/material.dart';

class KeepsLive extends StatefulWidget {
  const KeepsLive({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  State<KeepsLive> createState() => _KeepsLiveState();
}

class _KeepsLiveState extends State<KeepsLive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child!;
  }

  @override
  bool get wantKeepAlive => false;
}