import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../widgets/molecules/row_icon_text.dart';
import '../../bloc/participant_bloc.dart';
import '../molecules/scan_button.dart';

class BannerParticipantAppBar extends StatefulWidget {
  const BannerParticipantAppBar({super.key, required this.event, required this.onBarcodeScanned});
  final dynamic Function(String) onBarcodeScanned;
  final Event event;

  @override
  State<BannerParticipantAppBar> createState() => _BannerParticipantAppBarState();
}

class _BannerParticipantAppBarState extends State<BannerParticipantAppBar> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantBloc, ParticipantState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 24.0),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: const Text(
                        "Participantes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 1, horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.event.name,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 1, horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 1,
                          ),
                          RowIconText(
                            icon: Image.asset(
                                "assets/icons/icon_calendar.png"),
                            text: widget.event.date.toString().split(" ").first.split("-").reversed.toList().join("/").replaceAll("-", "/"),
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          RowIconText(
                            icon: Image.asset(
                                "assets/icons/icon_timer.png"),
                            text: obtenerDuracion(widget.event.date,
                                widget.event.duration),
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          RowIconText(
                            icon: Image.asset(
                                "assets/icons/icon_person.png"),
                            text:
                            "${widget.event.participants.length} / ${widget.event.capacity}",
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          ScanButton(
                              onBarcodeScanned: widget.onBarcodeScanned),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        
      }
    );
  }

  String obtenerDuracion(DateTime fechaEvento, int duracionMinutos) {
    DateTime horaFin = fechaEvento.add(Duration(minutes: duracionMinutos));

    String dosDigitos(int n) {
      if (n >= 1) return "$n";
      return "0$n";
    }

    String horaInicio =
        '${dosDigitos(fechaEvento.hour)}:${dosDigitos(fechaEvento.minute)}';
    String horaTermino =
        '${dosDigitos(horaFin.hour)}:${dosDigitos(horaFin.minute)}';

    return '$horaInicio - $horaTermino';
  }

}
