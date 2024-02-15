import 'package:flutter/material.dart';

import '../../../../core/formatters/uppercase_text_formatter.dart';

class InputDistrict extends StatefulWidget {
  const InputDistrict({super.key, required this.controller, this.suffix, this.prefix, this.enabled});

  final TextEditingController controller;
  final bool? suffix;
  final bool? prefix;
  final bool? enabled;

  @override
  State<InputDistrict> createState() => _InputDistrictState();
}

class _InputDistrictState extends State<InputDistrict> {
  late bool suffix;
  late bool prefix;
  @override
  void initState() {
    suffix = widget.suffix ?? false;
    prefix = widget.prefix ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(250, 250, 250, 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 2,
              offset: Offset(0, 2),
            )
          ]
      ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: "Distrito",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          suffixIcon:
          suffix ? Image.asset("assets/icons/icon_location.png") : null,
          prefixIcon: prefix ? Image.asset("assets/icons/icon_location.png") : null,
        ),
        inputFormatters: [UpperCaseTextFormatter()],
        keyboardType: TextInputType.text,
        enabled: widget.enabled ?? true,
      ),
    );
  }

}