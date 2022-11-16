import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_event.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_state.dart';
import 'package:clinic/features/sick/presentation/widgets/Sick_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart' as di;
import '../../../clinic/presentation/bloc/actions_clinic_bloc.dart';
import '../../../clinic/presentation/bloc/actions_clinic_event.dart';
import '../../../visitor/presentation/widgets/message_display_widget.dart';
import 'add_sick.dart';

class GetAllSicksPage extends StatelessWidget{
  final String? typeOfLogin;

  const GetAllSicksPage({Key? key, this.typeOfLogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddUpdateGetClinicBloc>(
        create: (context) {
          return di.sl<AddUpdateGetClinicBloc>()..add(GetClinicEvent());
        },
        child:Scaffold(
          appBar: AppBar(title: Text('Sick')),
          body: _buildBody(),
          floatingActionButton: _buildFloatingBtn(context),

        )
    );
  }
  Widget _buildBody(){
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child:  BlocBuilder<AddUpdateGetSickBloc, AddUpdateGetSickState>(
          builder: (context, state) {
            print(state);
            if (state is LoadingSicksState){
              return LoadingWidget();
            }else if (state is LoadedSicksState) {
              return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: SickListWidget(sick: state.sicks, typeOfLogin: typeOfLogin));
            } else if (state is ErrorSicksState) {
              return MessageDisplayWidget(message: state.message, typeOfLogin: typeOfLogin);
            }
            return LoadingWidget();
          },
        ) ,


    );
  }


  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> AddSickPage()));
      },
      child: Icon(Icons.add),
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetSickBloc>(context).add(RefreshSickEvent());
    }
    catch(e){
      print(e);
    }
  }
}