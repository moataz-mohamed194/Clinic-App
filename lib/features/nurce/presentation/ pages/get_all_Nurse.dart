import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../../../../injection_container.dart' as di;
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/Nurse_bloc.dart';
import '../bloc/Nurse_event.dart';
import '../bloc/Nurse_state.dart';
import '../widgets/nurse_list_widget.dart';
import 'add_Nurse.dart';

class GetNurseDataPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nurse Data')),
      body: _buildBody(),
      floatingActionButton:_buildFloatingBtn(context),

    );
  }
  Widget _buildBody(){
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: BlocProvider<AddGetNurseBloc>(
            create: (context) => di.sl<AddGetNurseBloc>()..add(GetNurseEvent()),
            child:  BlocBuilder<AddGetNurseBloc, AddGetNurseState>(
              builder: (context, state) {
                if (state is LoadingNurseState){
                  return LoadingWidget();
                }else if (state is LoadedNurseState) {
                  return RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: NurseListWidget( nurse: state.nurse,));
                } else if (state is ErrorNurseState) {
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
            MaterialPageRoute(builder: (_)=> AddNewNursePage()));
      },
      child: Icon(Icons.add),
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddGetNurseBloc>(context)..add(GetNurseEvent());
    }
    catch(e){
      print(e);
    }
  }
}