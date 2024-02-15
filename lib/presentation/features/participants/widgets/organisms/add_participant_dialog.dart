import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'package:vistocheck/presentation/core/messages/scaffold_messages.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../../domain/entities/participant.dart';
import '../../bloc/participant_bloc.dart';
import '../atoms/input_company.dart';
import '../atoms/input_district.dart';
import '../atoms/input_dni.dart';
import '../atoms/input_name.dart';
import '../atoms/input_phone.dart';

class AddParticipantDialog extends StatefulWidget {
  const AddParticipantDialog({super.key, required this.event});

  final Event event;

  @override
  State<AddParticipantDialog> createState() => _AddParticipantDialogState();
}

class _AddParticipantDialogState extends State<AddParticipantDialog> {
  final _textControllerName = TextEditingController();
  final _textControllerDni = TextEditingController();
  final _textControllerCompany = TextEditingController();
  final _textControllerPhone = TextEditingController();
  final _textControllerDistrict = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParticipantBloc, ParticipantState>(
      listener: (context, state) {
        if (state is SuccessAddingParticipant ||
            state is ErrorAddingParticipant) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
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
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 50),
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ]),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Registrar Participante",
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
                      suffix: true,
                    ),
                    InputName(
                      controller: _textControllerName,
                      suffix: true,
                    ),
                    InputCompany(
                      controller: _textControllerCompany,
                      suffix: true,
                    ),
                    InputPhone(
                      controller: _textControllerPhone,
                      suffix: true,
                    ),
                    InputDistrict(
                      controller: _textControllerDistrict,
                      suffix: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_textControllerDni.text == "" ||
                                  _textControllerName.text == "") {
                                _textControllerDni.text = "";
                                _textControllerName.text = "";
                                _textControllerCompany.text = "";
                                _textControllerPhone.text = "";
                                _textControllerDistrict.text = "";

                                showErrorMessage(context, "Dni y nombre son obligatorios");
                                Navigator.pop(context);

                              } else {
                                registrarParticipante(context);
                              }
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
        );
      },
    );
  }

  void registrarParticipante(BuildContext contextt) {
    ObjectId id = ObjectId();
    int dni =
        _textControllerDni.text == "" ? 0 : int.parse(_textControllerDni.text);
    String name = _textControllerName.text;
    String status = "Creado"; // Migrado - Creado
    String statusAssist = "Asistio"; // Asistio - No Asistio
    DateTime registrationDate = DateTime.now();
    ObjectId idEvent = widget.event.id;
    int? phone = _textControllerPhone.text == ""
        ? 0
        : int.parse(_textControllerPhone.text);
    String? company = _textControllerCompany.text;
    String? district = _textControllerDistrict.text;
    String? email = "";
    int? age = 0;
    String? gender = "";
    String? urlPhoto = "";
    DateTime? asistenceDate;

    Participant participant = Participant(
        id, dni, name, status, statusAssist, registrationDate, idEvent,
        phone: phone,
        company: company,
        district: district,
        email: email,
        age: age,
        gender: gender,
        urlPhoto: urlPhoto,
        asistenceDate: asistenceDate);
    BlocProvider.of<ParticipantBloc>(context)
        .addParticipant(widget.event, participant);
  }
}
