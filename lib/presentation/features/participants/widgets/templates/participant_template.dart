import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistocheck/presentation/core/messages/scaffold_messages.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../../domain/entities/participant.dart';
import '../../bloc/participant_bloc.dart';
import '../organisms/add_participant_dialog.dart';
import '../organisms/banner_participant_appbar.dart';
import '../organisms/confirm_participant_dialog.dart';
import '../organisms/list_participant_body.dart';
import '../organisms/search_participant_appbar.dart';

class ParticipantTemplate extends StatefulWidget {
  const ParticipantTemplate({super.key, required this.event});

  final Event event;

  @override
  State<ParticipantTemplate> createState() => _ParticipantTemplateState();
}

class _ParticipantTemplateState extends State<ParticipantTemplate> {
  late Event event;
  String barcode = '';
  @override
  void initState() {
    event = widget.event;
    BlocProvider.of<ParticipantBloc>(context).fetchParticipants(event);
    super.initState();
  }


  @override
  void didUpdateWidget(covariant ParticipantTemplate oldWidget) {
    if (widget.event.hashCode != oldWidget.event.hashCode) {
      setState(() {
        event = widget.event;
      });
      BlocProvider.of<ParticipantBloc>(context).fetchParticipants(widget.event);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (widget.event.hashCode != hashCode) {
      setState(() {
        event = widget.event;
      });
      BlocProvider.of<ParticipantBloc>(context).fetchParticipants(widget.event);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      //appBar: getAppbarParticipant(context),
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ParticipantBloc>(context)
              .fetchParticipants(widget.event);
        },
        child: BlocConsumer<ParticipantBloc, ParticipantState>(
          listener: (context, state) {
            if (state is SuccessModifyingParticipant) {
              showSuccessMessage(context, "Se registró la asistencia" );
            } else if (state is ErrorModifyingParticipant) {
              showErrorMessage(context, "Error al registrar la asistencia" );
            }else if (state is SuccessModifyingParticipant) {
              showSuccessMessage(context, "Se modificó la asistencia");
            } else if (state is ErrorModifyingParticipant) {
              showErrorMessage(context, "Error al modificar la asistencia");
            }else if (state is ErrorLoadingParticipants) {
              showErrorMessage(context, "Error al cargar los participantes");
            }else if (state is SuccessLoadingParticipants) {
              showSuccessMessage(context, "Se cargaron los participantes");
            }
          },
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/bannerParticipant.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                BannerParticipantAppBar(
                  event: widget.event,
                  onBarcodeScanned: (String code) {
                    setState(() {
                      barcode = code;
                    });
                    Participant participant = BlocProvider.of<ParticipantBloc>(context)
                        .filterParticipants(widget.event,code, "name");

                    openParticipantDialog(context, BlocProvider.of<ParticipantBloc>(context),
                        widget.event, participant);
                  },
                ),
                DraggableScrollableSheet(
                  initialChildSize: (MediaQuery.of(context).orientation ==
                          Orientation.landscape)
                      ? 1.0
                      : 0.65,
                  minChildSize: (MediaQuery.of(context).orientation ==
                          Orientation.landscape)
                      ? 1.0
                      : 0.65,
                  maxChildSize: 1.0,
                  builder: (context, scrollController) {


                    // Usar un Key único basado en el ID del evento
                    final key = ValueKey(state.participants.hashCode);
                    return Container(
                      color: const Color.fromRGBO(245, 245, 245, 1.0),
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SearchParticipantAppBar(
                            onChanged: (searchText, typeFilter) =>
                                BlocProvider.of<ParticipantBloc>(context)
                                    .filterParticipants(widget.event ,searchText, typeFilter),
                            dni: barcode,
                          ),
                          ListParticipantBody(
                            key: key,
                              participants:
                                  state is SuccessFilteringParticipants
                                      ? state.filteredParticipants
                                      : state.participants,
                              event: widget.event),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showAddParticipantDialog(BlocProvider.of<ParticipantBloc>(context));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          width: 60,
          height: 60,
          color: Colors.transparent,
          child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset("assets/icons/icon_floating_button.png")),
        ),
      ),
    );
  }

  void showAddParticipantDialog(ParticipantBloc blocValue) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return BlocProvider.value(
            value: blocValue,
            child: AddParticipantDialog(
              event: widget.event,
            ),
          );
        });
  }

  void openParticipantDialog(context, ParticipantBloc blocValue, Event event,
      Participant participant) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return BlocProvider.value(
            value: blocValue,
            child: ConfirmParticipantDialog(
              event: widget.event,
              participant: participant,
              status: "confirm",
              barcode: barcode,
            ),
          );
        });
  }

}
