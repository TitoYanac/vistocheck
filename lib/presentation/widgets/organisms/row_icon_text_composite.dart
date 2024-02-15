import 'package:flutter/material.dart';

import '../molecules/row_icon_text.dart';

class RowIconTextComposite extends StatefulWidget {
  const RowIconTextComposite({super.key, required this.rowIconText});

  final List<RowIconText> rowIconText;

  @override
  State<RowIconTextComposite> createState() => _RowIconTextCompositeState();
}

class _RowIconTextCompositeState extends State<RowIconTextComposite> {
  late List<RowIconText> rowIconText;
  @override
  void initState() {
    rowIconText = widget.rowIconText;
    super.initState();
  }

  @override
  didUpdateWidget(covariant RowIconTextComposite oldWidget) {
    if (oldWidget.rowIconText != widget.rowIconText) {
      setState(() {
        rowIconText = widget.rowIconText;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: rowIconText
            .map((e) => Expanded(
                  flex: 1,
                  child: RowIconText(
                    icon: e.icon,
                    text: e.text,
                  ),
                ))
            .toList());
  }
}
