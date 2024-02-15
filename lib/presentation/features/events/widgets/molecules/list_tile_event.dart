import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../bloc/realm_bloc.dart';
import '../../../../widgets/molecules/row_icon_text.dart';
import '../../../../widgets/organisms/row_icon_text_composite.dart';
import '../../../participants/widgets/pages/participant_page.dart';

class ListTileEvent extends StatefulWidget {
  const ListTileEvent({super.key, required this.event});

  final Event event;

  @override
  State<ListTileEvent> createState() => _ListTileEventState();
}

class _ListTileEventState extends State<ListTileEvent> {
  String status = "";
  Color statusColor = Colors.red;
  @override
  void initState() {
    status = widget.event.status;
    validateStatusColor();
    super.initState();
  }
  @override
  void didUpdateWidget(covariant ListTileEvent oldWidget) {
    if (widget.event.status != oldWidget.event.status) {
      setState(() {
        status = widget.event.status;
      });
      validateStatusColor();
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  void didChangeDependencies() {
    if (widget.event.status != status) {
      setState(() {
        status = widget.event.status;
      });
      validateStatusColor();
    }

    super.didChangeDependencies();
  }
  void validateStatusColor() {
    setState(() {
      if (status == "Activo") {
        statusColor = Colors.green;
      }
      if (status == "Inactivo") {
        statusColor = Colors.red;
      }
      if (status == "Cancelado") {
        statusColor = Colors.grey;
      }
    });
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
                // Acción al presionar el botón
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<RealmBloc>(context),
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
                    RowIconText(
                        icon: Image.asset("assets/icons/icon_bookmark.png"),
                        text: (widget.event.name.isEmpty || widget.event.name == "")?
                        "(No especificado)"
                        :widget.event.name,
                        fontWeight: FontWeight.bold),
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
