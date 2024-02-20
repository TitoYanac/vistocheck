import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../../domain/entities/participant.dart';
import '../../bloc/participant_bloc.dart';
import '../atoms/input_company.dart';
import '../atoms/input_district.dart';
import '../atoms/input_dni.dart';
import '../atoms/input_name.dart';
import '../atoms/input_phone.dart';

class ConfirmParticipantDialog extends StatefulWidget {
  const ConfirmParticipantDialog(
      {super.key,
      required this.event,
      this.participant,
      required this.status,
      required this.barcode});
  final Event event;
  final Participant? participant;
  final String status;
  final String barcode;

  @override
  State<ConfirmParticipantDialog> createState() =>
      _ConfirmParticipantDialogState();
}

class _ConfirmParticipantDialogState extends State<ConfirmParticipantDialog> {
  late final _textControllerName = TextEditingController();
  late final _textControllerDni = TextEditingController();
  late final _textControllerCompany = TextEditingController();
  late final _textControllerPhone = TextEditingController();
  late final _textControllerDistrict = TextEditingController();
  @override
  void initState() {
    if (widget.participant != null) {
      _textControllerName.text = widget.participant!.name != null && widget.participant!.name.toString().isNotEmpty
          ? widget.participant!.name.toString()
          : "(No especificado)";

      _textControllerDni.text = widget.participant!.dni != null
          ? widget.participant!.dni.toString()
          : "(No especificado)";

      _textControllerCompany.text = widget.participant!.company != null && widget.participant!.company.toString().isNotEmpty
          ? widget.participant!.company.toString()
          : "(No especificado)";

      _textControllerPhone.text = widget.participant!.phone != null && widget.participant!.phone.toString().isNotEmpty
          ? widget.participant!.phone.toString()
          : "(No especificado)";

      _textControllerDistrict.text = widget.participant!.district != null && widget.participant!.district.toString().isNotEmpty
          ? widget.participant!.district.toString()
          : "(No especificado)";
    } else {
      // Si widget.participant es null, asigna "(No especificado)" a todos los controladores de texto
      _textControllerName.text = "(No especificado)";
      _textControllerDni.text = "(No especificado)";
      _textControllerCompany.text = "(No especificado)";
      _textControllerPhone.text = "(No especificado)";
      _textControllerDistrict.text = "(No especificado)";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParticipantBloc, ParticipantState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Dialog(
              backgroundColor: Colors.white,
              clipBehavior: Clip.hardEdge,
              insetPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: MediaQuery.of(context).size.height * 0.15,
              ),
              child: Center(
                child: Container(
                  height: 550,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Asistencia",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputDni(
                        controller: _textControllerDni,
                        prefix: true,
                        enabled: false,
                      ),
                      InputName(
                        controller: _textControllerName,
                        prefix: true,
                        enabled: false,
                      ),
                      InputCompany(
                        controller: _textControllerCompany,
                        prefix: true,
                        enabled: false,
                      ),
                      InputPhone(
                        controller: _textControllerPhone,
                        prefix: true,
                        enabled: false,
                      ),
                      InputDistrict(
                        controller: _textControllerDistrict,
                        prefix: true,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text("Cerrar"),
                            ),
                          ) ,
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ParticipantBloc>(context)
                                    .recordAsistence(
                                    widget.barcode, widget.event);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text("Registrar"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
