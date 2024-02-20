import 'package:flutter/material.dart';

import '../../../../core/validators/input_validators.dart';

class InputDni extends StatefulWidget {
  const InputDni({super.key, required this.controller, this.suffix, this.prefix, this.enabled});

  final TextEditingController controller;
  final bool? suffix;
  final bool? prefix;
  final bool? enabled;

  @override
  State<InputDni> createState() => _InputDniState();
}

class _InputDniState extends State<InputDni> {
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
          hintText: "DNI*",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          suffixIcon: suffix ? Image.asset("assets/icons/icon_dni.png") : null,
          prefixIcon: prefix ? Image.asset("assets/icons/icon_dni.png") : null,
        ),
        keyboardType: TextInputType.number,
        enabled: widget.enabled ?? true,
        onChanged: (value) {
          // Elimina cualquier carácter que no sea un número
          String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

          // Actualiza el texto en el campo
          widget.controller.value = widget.controller.value.copyWith(
            text: newValue,
            selection: TextSelection.collapsed(offset: newValue.length),
            composing: TextRange.empty,
          );

          // Limita la longitud a 8 dígitos
          checkLength(8, widget.controller);
        },
      ),
    );
  }
}