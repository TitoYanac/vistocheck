import 'dart:math';

import 'package:flutter/material.dart';

class SearchParticipantAppBar extends StatefulWidget {
  const SearchParticipantAppBar({super.key, required this.onChanged, required this.dni});

  final Function(dynamic searchText, dynamic typeFilter) onChanged;

  final String dni;

  @override
  State<SearchParticipantAppBar> createState() => _SearchParticipantAppBarState();
}

class _SearchParticipantAppBarState extends State<SearchParticipantAppBar> {
  final TextEditingController controller = TextEditingController();
  bool enabled = true;

  @override
  void didUpdateWidget(covariant SearchParticipantAppBar oldWidget) {
    if(widget.dni != oldWidget.dni && widget.dni != "") {
      setState(() {
        controller.text = widget.dni;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    Widget body = SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 80.0,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: InkWell(
                            onTap: () async {
                              controller.clear();
                              setState(() {
                                enabled = true;
                              });
                              widget.onChanged(controller.text, "");
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              width: 20,
                              height: 20,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child:
                                Image.asset("assets/icons/icon_search.png"),
                              ),
                            ),
                          ),
                          prefixIcon: InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                builder: (BuildContext context, Widget? child) {
                                  var brightness = MediaQuery.of(context).platformBrightness;
                                  bool darkModeOn = brightness == Brightness.dark;
                                  return Theme(
                                    data: (darkModeOn ? ThemeData.dark() : ThemeData.light()).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Colors.blue, // Color del fondo del día seleccionado y color del texto de los botones
                                        onPrimary: Colors.white, // Color del texto del día seleccionado y el borde del contenedor del día seleccionado
                                        surface: Colors.white, // Color de fondo del popup del calendario
                                        surfaceTint: Colors.white, // Color fondo del popup del calendario x2 con opacidad
                                        onSurface: Colors.black, // Color del texto donde de los meses y días no seleccionados
                                        background: Colors.white, // Color de fondo del diálogo
                                        onBackground: Colors.black, // Color del texto del diálogo
                                        outlineVariant: Colors.red, // Color de la linea separadora
                                        onSurfaceVariant: Colors.red, // Color del texto de la cabecera del calendario
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2037),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  controller.text = pickedDate.toString().split(" ").first;
                                  enabled = true;
                                });
                                widget.onChanged(controller.text, "date");
                              } else {
                                setState(() {
                                  enabled = true;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              width: 20,
                              height: 20,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child:
                                Image.asset("assets/icons/icon_calendar.png"),
                              ),
                            ),
                          ),
                          hintText: 'Buscar Participante',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 100,right: 100,top: 8),
                          isDense: false,
                        ),
                        onChanged: (value) {
                          print("value: $value");
                          String inputType = determineInputType(value);
                          print("inputType: $inputType");
                          widget.onChanged(value, inputType);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      pinned: true,
      floating: false,
    );
    return body;
  }

  String determineInputType(String value) {
    // Expresiones regulares para validar fecha, nombre y DNI
    RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    RegExp nameRegExp = RegExp(r'^[A-Za-z\s]+$');
    RegExp dniRegExp = RegExp(r'^\d{8}[A-Za-z]$');

    if (dateRegExp.hasMatch(value)) {
      return "date";
    } else if (nameRegExp.hasMatch(value)) {
      return "name";
    } else if (dniRegExp.hasMatch(value)) {
      return "dni";
    } else {
      return "unknown";
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
