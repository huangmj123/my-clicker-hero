import 'package:flutter/material.dart';

class NormalTarget extends StatefulWidget {
  final Color color;
  final int hp;
  final double taken;
  final void Function()? onTouch;
  const NormalTarget({required this.color,required this.hp, required this.taken,required this.onTouch,super.key});

  @override
  State<NormalTarget> createState() => _NormalTargetState();
}

class _NormalTargetState extends State<NormalTarget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: widget.onTouch, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // color: widget.color,
              decoration: BoxDecoration(border: Border.all(),color: widget.color),
              height: 75,
              width: 75 * (widget.taken / widget.hp)
            ),Container(
              color: Colors.black,
              height: 75,
              width: 75 * ((widget.hp - widget.taken) / widget.hp)
            )
          ],
        ),
          ),
        Text("${(widget.hp - widget.taken).toStringAsFixed(2)} / ${widget.hp}")
      ],
    );
  }
}