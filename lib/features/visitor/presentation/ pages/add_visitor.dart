import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../bloc/add_update_visitor/add_update_visitor_bloc.dart';
import '../widgets/form_widget.dart';

class VisitorAddPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context: context, title: S.of(context).AddVisitor,),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateVisitorBloc, AddUpdateVisitorState>(
          listener: (context, state){
            if (state is MessageAddUpdateVisitorState){

              SnackBarMessage().showSuccesSnackBar(message: state.message, context: context);
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (_) => GetAllVisitors()), (route) => false);
              Navigator.pop(context);
            }else if (state is ErrorAddUpdateVisitorState){

              SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (_) => GetAllVisitors()), (route) => false);

            }
          },
          builder: (context, state) {
            if (state is LoadingAddUpdateVisitorState){
              return LoadingWidget();
            }
            return FormVisitorWidget();

          },
        ),
      ),
    );
  }

}