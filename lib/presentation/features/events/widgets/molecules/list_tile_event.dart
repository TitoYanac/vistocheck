import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../widgets/molecules/row_icon_text.dart';
import '../../../../widgets/organisms/row_icon_text_composite.dart';
import '../../../auth/bloc/login_bloc.dart';
import '../../../participants/widgets/pages/participant_page.dart';

class ListTileEvent extends StatefulWidget {
  const ListTileEvent({super.key, required this.event});

  final Event event;

  @override
  State<ListTileEvent> createState() => _ListTileEventState();
}

class _ListTileEventState extends State<ListTileEvent> {
  String status = "";
  Color statusColor = Colors.yellow;
  Timer? timer;

  @override
  void initState() {
    super.initState();


    status = validateStatus(widget.event);
    print("status $status");
    statusColor = getStatusColor(status);
    print("statuscolor ${statusColor?.toString()}");
  }

  @override
  void dispose() {
    // Cancelar el temporizador al eliminar el widget para evitar pérdidas de memoria
    timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ListTileEvent oldWidget) {
    if (widget.event.status != oldWidget.event.status) {
      setState(() {
        statusColor = getStatusColor(validateStatus(widget.event));
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  void didChangeDependencies() {
    if (widget.event.status != status) {
      setState(() {
        statusColor = getStatusColor(validateStatus(widget.event));
      });
    }
    super.didChangeDependencies();
  }

  String validateStatus(Event event) {
    DateTime dateInitEvent = event.date.add(const Duration(hours: 5)).toLocal();
    DateTime dateEndEvent = dateInitEvent.add(Duration(minutes: event.duration));
    DateTime now = DateTime.now();

    if (dateInitEvent.isBefore(now) && dateEndEvent.isAfter(now)) {
      return "En curso";
    }
    if (dateEndEvent.isBefore(now)) {
      return "Finalizado";
    }

    if (dateInitEvent.isAfter(now.add(const Duration(days: 3)))) {
      return "Proximamente";
    }

    return "En pocos dias";
  }

  Color getStatusColor(String status) {
    print("consiguiendo ${widget.event.name} color status $status");
    switch (status) {
      case "Proximamente":
        print("Proximamente");
        print("grey");
        return Colors.grey;
      case "En pocos dias":
        print("En pocos dias");
        print("orange");
        return Colors.orange;
      case "En curso":
        print("En curso");
        print("green");
        return Colors.green;
      case "Finalizado":
        print("Finalizado");
        print("red");
        return Colors.red;
      default:
        print("default");
        print("black");
        return Colors.black; // Color por defecto en caso de un estado desconocido
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                // Acción al presionar el botón
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<LoginBloc>(context),
                        child: ParticipantPage(event: widget.event),
                      ),
                    ),
                  );
                });

              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    statusColor), // Color del efecto splash
                backgroundColor: MaterialStateProperty.all(
                    Colors.white), // Color de fondo del botón
                foregroundColor: MaterialStateProperty.all(
                  Colors.black,
                ),
                surfaceTintColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                //height: 100,
                width: MediaQuery.of(context).size.width,
                constraints:
                    const BoxConstraints(minHeight: 100, maxWidth: 560),
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RowIconText(
                              icon: Image.asset("assets/icons/icon_bookmark.png"),
                              text: (widget.event.name.isEmpty || widget.event.name == "")?
                              "(No especificado)"
                              :widget.event.name,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(status, style: TextStyle(color: statusColor)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RowIconTextComposite(rowIconText: [
                      RowIconText(
                          icon: Image.asset("assets/icons/icon_calendar.png"),
                          text: widget.event.date.toString().split(" ").first.split("-").reversed.toList().join("/").replaceAll("-", "/"),),
                      RowIconText(
                          icon: Image.asset("assets/icons/icon_timer.png"),
                          text: widget.event.date.toString().split(" ").last.toString().split(".").first.toString().substring(0,5)),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    RowIconText(
                        icon: Image.asset("assets/icons/icon_location.png"),
                        text: (widget.event.address == "" ||widget.event.address!.isEmpty)
                            ?"(No especificado)"
                            :widget.event.address??("No especificado"),),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 10, // Ancho de la barra
                decoration: BoxDecoration(
                  color: statusColor, // Color de la barra
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
