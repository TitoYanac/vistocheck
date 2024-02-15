import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../../domain/entities/participant.dart';
import '../../../../widgets/molecules/row_icon_text.dart';
import '../../bloc/participant_bloc.dart';
import '../organisms/show_participant_dialog.dart';

class ListTileParticipant extends StatefulWidget {
  const ListTileParticipant({super.key, required this.participant, required this.event});
  final Event event;
  final Participant participant;

  @override
  State<ListTileParticipant> createState() => _ListTileParticipantState();
}

class _ListTileParticipantState extends State<ListTileParticipant> {
  String status = "";
  String statusAssist = "";
  Color statusColor = Colors.red;
  @override
  void initState() {
    status = widget.participant.status;
    statusAssist = widget.participant.statusAssist;
    validateStatusColor();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if (widget.participant.status.hashCode != status.hashCode
        || widget.participant.statusAssist.hashCode != statusAssist.hashCode) {
      setState(() {
        print("didChangeDependencies");
        print("actualizando estados : ${widget.participant.status}");
        print("actualizando assist : ${widget.participant.statusAssist}");
        status = widget.participant.status;
        statusAssist = widget.participant.statusAssist;
      });
      validateStatusColor();
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ListTileParticipant oldWidget) {
    if (widget.participant.status.hashCode != oldWidget.participant.status.hashCode
    || widget.participant.statusAssist.hashCode != oldWidget.participant.statusAssist.hashCode) {
      setState(() {

        print("didUpdateWidget");
        print("actualizando estados : ${widget.participant.status}");
        print("actualizando assist : ${widget.participant.statusAssist}");

        status = widget.participant.status;
        statusAssist = widget.participant.statusAssist;
      });
      validateStatusColor();
    }
    super.didUpdateWidget(oldWidget);
  }
  void openParticipantDialog(context, ParticipantBloc blocValue, Event event) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return BlocProvider.value(
            value: blocValue,
            child: ShowParticipantDialog(
              event: event,
              participant: widget.participant,
              status: "ok",
            ),
          );
        });
  }
  void validateStatusColor() {
    setState(() {
      if (status == "Migrado") {
        statusColor = Colors.red;
      }
      if (status == "Creado") {
        statusColor = Colors.orange;
      }
      if (statusAssist == "Asistio") {
        statusColor = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: () {
              openParticipantDialog(context, BlocProvider.of<ParticipantBloc>(context), widget.event);
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
              constraints: const BoxConstraints(minHeight: 100, maxWidth: 560),
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        RowIconText(
                            icon: Image.asset("assets/icons/icon_dni.png"),
                            text: (widget.participant.dni.toString().isEmpty
                                || widget.participant.dni.toString() == "0"
                                || widget.participant.dni.toString() == "")
                                ?"(No especificado)"
                                :widget.participant.dni.toString(),
                            fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(112, 112, 112, 1),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        RowIconText(
                            icon: Image.asset("assets/icons/icon_person.png"),
                            text: (widget.participant.name.isEmpty || widget.participant.name == "")
                                ?"(No especificado)"
                                :widget.participant.name.toUpperCase(),
                            fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(112, 112, 112, 1),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        RowIconText(
                            icon: Image.asset("assets/icons/icon_factory.png"),
                            text: (widget.participant.company==null
                                || widget.participant.company == "")
                                ?"(No especificado)"
                                :widget.participant.company!.toUpperCase(),
                          color: const Color.fromRGBO(165, 165, 165, 1),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        RowIconText(
                            icon: Image.asset("assets/icons/icon_phone.png"),
                            text: (widget.participant.phone == null
                            || widget.participant.phone.toString() == ""
                            || widget.participant.phone == 0)
                                ?"(No especificado)"
                                :widget.participant.phone!.toString(),
                          color: const Color.fromRGBO(112, 112, 112, 1),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
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
    );
  }




}
