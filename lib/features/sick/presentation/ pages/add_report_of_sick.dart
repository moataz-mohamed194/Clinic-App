import 'package:clinic/features/sick/presentation/bloc/add_sick_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import '../bloc/add_sick_bloc.dart';
import '../bloc/add_sick_state.dart';

class AddReportOfSickPage extends StatelessWidget{
  final int? idOfSick;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reportController = TextEditingController();

  AddReportOfSickPage({Key? key, required this.idOfSick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).AddMedicalReExamination),
      ),
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
            return Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: _reportController,
                validator: (val) => val!.isEmpty ? 'must add the name of sick' : null,
                decoration: InputDecoration(hintText: S.of(context).Report),
                minLines: 2,
                maxLines: 2,
              ),
            ),
            ElevatedButton.icon(
            onPressed:()=> validateFormAddReportPost(context, this.idOfSick??0),
            icon: Icon(Icons.add),
            label: Text(S.of(context).AddSick)
            )
                  ],
              ),
            );

          },

        ),
      ),
    );
  }
  void validateFormAddReportPost(BuildContext context, int id) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {

        BlocProvider.of<AddUpdateGetSickBloc>(context)
            .add(AddSickReportEvent(id: id, report: _reportController.text));
      }
      catch (e){
        print(e);
      }


    }
  }

}