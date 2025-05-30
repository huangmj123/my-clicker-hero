import 'package:flutter/material.dart';

class NormalTarget extends StatefulWidget {
  final int hp;
  final double taken;
  final void Function()? onTouch;
  const NormalTarget({required this.hp, required this.taken,required this.onTouch,super.key});

  @override
  State<NormalTarget> createState() => _NormalTargetState();
}

class _NormalTargetState extends State<NormalTarget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: widget.onTouch, child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.green,
                height: 50,
                width: 50 * (widget.taken / widget.hp)
              ),Container(
                color: Colors.black,
                height: 50,
                width: 50 * ((widget.hp - widget.taken) / widget.hp)
              )
            ],
          ),
          ),
          ),
        Text("${(widget.hp - widget.taken).toStringAsFixed(2)} / ${widget.hp}")
      ],
    );
  }
}