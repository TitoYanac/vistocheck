import 'package:flutter/material.dart';

class RowIconText extends StatefulWidget {
  const RowIconText({super.key, required this.icon, required this.text, this.fontWeight, this.color});

  final Widget icon;
  final String text;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  State<RowIconText> createState() => _RowIconTextState();
}

class _RowIconTextState extends State<RowIconText> {
  late Widget icon;
  late String text;
  @override
  void initState() {
    icon = widget.icon;
    text = widget.text;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RowIconText oldWidget) {
    if (oldWidget.icon != widget.icon || oldWidget.text != widget.text) {
      setState(() {
        icon = widget.icon;
        text = widget.text;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 30, height: 30,
              color: Colors.transparent,
              child: widget.icon,),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                widget.text,
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: widget.fontWeight,
                  color: widget.color??Colors.black,
                  fontSize: 16
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
