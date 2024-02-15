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

class ShowParticipantDialog extends StatefulWidget {
  const ShowParticipantDialog({super.key, required this.event, required this.participant, required this.status});

  final Event event;
  final Participant participant;
  final String status;

  @override
  State<ShowParticipantDialog> createState() => _ShowParticipantDialogState();
}

class _ShowParticipantDialogState extends State<ShowParticipantDialog> {
  late final _textControllerName = TextEditingController();
  late final _textControllerDni = TextEditingController();
  late final _textControllerCompany = TextEditingController();
  late final _textControllerPhone = TextEditingController();
  late final _textControllerDistrict = TextEditingController();
  @override
  void initState() {
    _textControllerName.text = widget.participant.name.toString();
    _textControllerDni.text = widget.participant.dni.toString();
    _textControllerCompany.text = widget.participant.company.toString();
    _textControllerPhone.text = widget.participant.phone.toString();
    _textControllerDistrict.text = widget.participant.district.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantBloc, ParticipantState>(
      bloc: BlocProvider.of<ParticipantBloc>(context),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Información",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      InputDni(controller: _textControllerDni,prefix: true,enabled: false,),
                      InputName(controller: _textControllerName,prefix: true,enabled: false,),
                      InputCompany(controller: _textControllerCompany,prefix: true,enabled: false,),
                      InputPhone(controller: _textControllerPhone,prefix: true,enabled: false,),
                      InputDistrict(controller: _textControllerDistrict,prefix: true,enabled: false,),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text("Ok"),
                            ),
                          ),
                          const SizedBox(width: 10,),
                        ],
                      ),
                    ],
                  ),
                ),),
            ),
          ),
        );
      },);
  }
}