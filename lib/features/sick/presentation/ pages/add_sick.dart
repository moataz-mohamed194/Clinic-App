import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import '../widgets/form_widget.dart';

class AddSickPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Add medical re-examination'),
      // ),
      appBar: generalAppBar(context: context, title: S.of(context).AddMedicalReExamination,),

      body: appBody(context),
    );
  }
  Widget appBody(BuildContext context){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateGetSickBloc, AddUpdateGetSickState>(
        listener: (context, state){
            if (state is MessageAddUpdateGetSickState){

              SnackBarMessage().showSuccesSnackBar(message: state.message, context: context);
              // Navigator.of(context).pushAndRemoveUntil(
              // MaterialPageRoute(builder: (_) => GetAllSicksPage()), (route) => false);
              Navigator.pop(context);
            }else if (state is ErrorSicksState){

            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (_) => GetAllVisitors()), (route) => false);

            }
          },
          builder: (context, state){
            if (state is LoadingAddUpdateVisitorState){
            return LoadingWidget();
            }
            return FormSickWidget();

            },

        ),
      ),
    );
  }
}