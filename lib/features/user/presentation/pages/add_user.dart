import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';
import '../widgets/form_widget.dart';

class AddUserPage extends StatelessWidget{
  final bool isItAdd;

  const AddUserPage({Key? key, required this.isItAdd}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isItAdd==true?'Add user':'Update user'),
      ),
      body: appBody(context),
    );
  }
  Widget appBody(BuildContext context){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateUserBloc, AddUpdateUserState>(
        listener: (context, state){
            if (state is MessageAddUpdateUserState){
              SnackBarMessage().showSuccesSnackBar(message: state.message, context: context);
              Navigator.pop(context);
            }else if (state is ErrorUsersState){
              SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state){
            if (state is LoadingAddUpdateVisitorState){
              return LoadingWidget();
            }
            return FormUserWidget(isItAdd:this.isItAdd);

            },

        ),
      ),
    );
  }
}