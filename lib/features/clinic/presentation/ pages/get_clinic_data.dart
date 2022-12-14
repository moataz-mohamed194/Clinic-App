
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../../../../injection_container.dart' as di;
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/actions_clinic_bloc.dart';
import '../bloc/actions_clinic_event.dart';
import '../bloc/actions_clinic_state.dart';
import '../widgets/clinic_list_widget.dart';
import 'Add_New_Clinic_data.dart';

class GetClinicDataPage extends StatelessWidget{
  final bool showAddAndEdit;

  const GetClinicDataPage({Key? key, required this.showAddAndEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clinic Data')),
      body: _buildBody(),
      floatingActionButton:showAddAndEdit==true? _buildFloatingBtn(context):Container(),

    );
  }
  Widget _buildBody(){
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: BlocProvider<AddUpdateGetClinicBloc>(
        create: (context) => di.sl<AddUpdateGetClinicBloc>()..add(GetClinicEvent()),
        child:  BlocBuilder<AddUpdateGetClinicBloc, AddUpdateGetClinicState>(
            builder: (context, state) {
              if (state is LoadingClinicState){
                return LoadingWidget();
              }else if (state is LoadedClinicState) {
                return RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: ClinicListWidget(clinic: state.clinic,
                        showAddAndEdit: showAddAndEdit));
              } else if (state is ErrorClinicState) {
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
            MaterialPageRoute(builder: (_)=> AddNewClinicDataPage(showAddAndEdit:showAddAndEdit)));
      },
      child: Icon(Icons.add),
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetClinicBloc>(context)..add(GetClinicEvent());
    }
    catch(e){
      print(e);
    }
  }
}