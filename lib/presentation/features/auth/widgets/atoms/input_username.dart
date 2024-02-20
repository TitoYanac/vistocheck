import 'package:flutter/material.dart';
import 'package:characters/characters.dart';



class InputUsername extends StatefulWidget {
  const InputUsername({
    super.key,
    required this.controller,
    this.suffix,
    this.prefix,
    this.enabled
  });

  final TextEditingController controller;
  final bool? suffix;
  final bool? prefix;
  final bool? enabled;

  @override
  State<InputUsername> createState() => _InputUsernameState();
}

class _InputUsernameState extends State<InputUsername> {
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
          ]),
      child: TextFormField(
    controller: widget.controller,
      enableIMEPersonalizedLearning: true,
      autocorrect: true,
      enableSuggestions: true,
      decoration: InputDecoration(
        hintText: "Usuario",
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        suffixIcon: suffix ? const Icon(Icons.account_circle_outlined) : null,
        prefixIcon: prefix ? const Icon(Icons.account_circle_outlined) : null,
      ),
      keyboardType: TextInputType.text,
      enabled: widget.enabled ?? true,
      onChanged: (value) {
        // Guarda la posición actual del cursor
        int oldLength = value.length;
        int cursorPos = widget.controller.selection.start;

        // Elimina los espacios en blanco y los emojis
        String newValue = value.replaceAll(' ', '');
        newValue = newValue.characters.where((ch) => ch.length == 1).join();

        // Calcula la nueva posición del cursor
        int newLength = newValue.length;
        int newCursorPos = cursorPos - (oldLength - newLength);
        newCursorPos = newCursorPos >= 0 ? newCursorPos : 0; // Asegura que la nueva posición del cursor no sea negativa

        // Actualiza el texto en el campo
        widget.controller.value = widget.controller.value.copyWith(
          text: newValue,
          selection: TextSelection.collapsed(offset: newCursorPos),
          composing: TextRange.empty,
        );
      },
    )
    ,
    );
  }
}
