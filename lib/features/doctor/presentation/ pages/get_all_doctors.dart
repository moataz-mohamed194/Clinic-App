
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../../../../injection_container.dart' as di;
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/doctor_bloc.dart';
import '../bloc/doctor_event.dart';
import '../bloc/doctor_state.dart';
import '../widgets/doctor_list_widget.dart';
import 'add_doctor.dart';

class GetDoctorDataPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctor Data')),
      body: _buildBody(),
      floatingActionButton:_buildFloatingBtn(context),

    );
  }
  Widget _buildBody(){
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: BlocProvider<AddGetDoctorBloc>(
            create: (context) => di.sl<AddGetDoctorBloc>()..add(GetDoctorEvent()),
            child:  BlocBuilder<AddGetDoctorBloc, AddGetDoctorState>(
              builder: (context, state) {
                if (state is LoadingDoctorState){
                  return LoadingWidget();
                }else if (state is LoadedDoctorState) {
                  return RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: DoctorListWidget( doctor: state.doctor,));
                } else if (state is ErrorDoctorState) {
                  return MessageDisplayWidget(message: state.message);
                }
                return LoadingWidget();
              },
            )
        )
    );
  }


  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (_)=> AddNewDoctorPage()));
      },
      child: Icon(Icons.add),
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddGetDoctorBloc>(context)..add(GetDoctorEvent());
    }
    catch(e){
      print(e);
    }
  }
}