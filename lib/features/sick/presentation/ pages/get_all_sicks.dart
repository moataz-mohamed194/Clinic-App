import 'dart:convert';

import 'package:clinic/features/sick/data/models/SickModel.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_event.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_state.dart';
import 'package:clinic/features/sick/presentation/widgets/Sick_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/sick.dart';
import '../../../../core/bloc/socket/socket_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/injection/injection_container.dart' as di;
import '../../../../core/widgets/message_display_widget.dart';
import '../../../../core/widgets/widget_app_bar.dart';
import '../../../../generated/l10n.dart';
import 'add_sick.dart';

class GetAllSicksPage extends StatelessWidget {
  final String? typeOfLogin;

  const GetAllSicksPage({Key? key, this.typeOfLogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
          context: context,
          title: S.of(context).WaitingForTheDoctorsExamination,
          showHomeIcon: true),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: BlocProvider<AddUpdateGetSickBloc>(
            create: (context) =>
                di.sl<AddUpdateGetSickBloc>()..add(GetSickEvent()),
            child: BlocBuilder<SocketBloc, SocketState>(
                builder: (context, stateSocket) {
                  String userType='';
                  String sickId='';
              if (stateSocket is SocketConnected) {
                final newData = json.decode(stateSocket.message.toString());
                userType =newData['userType'];
                sickId = newData['sickId'];
              }
              return BlocBuilder<AddUpdateGetSickBloc, AddUpdateGetSickState>(
                builder: (context, state) {
                  if (state is LoadingSicksState) {
                    return LoadingWidget();
                  } else if (state is LoadedSicksState) {
                    List<Sick> doctorData = state.sicks
                        .where(
                            (element) => element.approved == true)
                        .toList();
                    List<Sick> nurseData = state.sicks;
                    if (userType== 'nurse') {
                      nurseData.map((sick) {
                        if (sick.id.toString() == sickId.toString()) {
                          doctorData.add( SickModel(id: sick.id,
                              name: sick.name,
                              phoneNumber: sick.phoneNumber,
                              approved: true,
                              pk:sick.pk,
                              addByName:sick.addByName,
                              doctorReport:sick.doctorReport,
                              time:sick.time,
                              approvedBy:sick.approvedBy,
                              typeOfStatment: sick.typeOfStatment));
                        }
                      }).toList();
                    }else if (userType== 'Doctor') {
                          nurseData.removeWhere((element) => element.id.toString()==sickId.toString());
                    }
                    return RefreshIndicator(
                        onRefresh: () => _onRefresh(context),
                        child:Column(
                          children: List.generate(typeOfLogin=='Doctor'?doctorData.length:nurseData.length, (index) => sickListWidget(
                              sick:typeOfLogin=='Doctor'?doctorData[index]:nurseData[index],

                              typeOfLogin: typeOfLogin, context: context)),
                        )
                        );
                  } else if (state is ErrorSicksState) {
                    return MessageDisplayWidget(message: state.message);
                  }
                  return LoadingWidget();
                },
              );
            })));
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddSickPage()));
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetSickBloc>(context).add(RefreshSickEvent());
    } catch (e) {
      print(e);
    }
  }
}
