import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/Nurse_bloc.dart';
import '../bloc/Nurse_state.dart';
import '../widgets/form_nurse_widget.dart';

class AddNewNursePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Nurse Data'),
      ),
      body: appBody(context),
    );
  }
  Widget appBody(BuildContext context){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddGetNurseBloc, AddGetNurseState>(
          listener: (context, state){
            if (state is MessageAddGetNurseState){
              SnackBarMessage().showSuccesSnackBar(message: state.message, context: context);
              Navigator.pop(context);
            }else if (state is ErrorNurseState){
              SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state){
            print(state);
            if (state is LoadingNurseState){
              return LoadingWidget();
            }
            return FormNurseWidget();

          },

        ),
      ),
    );
  }

}