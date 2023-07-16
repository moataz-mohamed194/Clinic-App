import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/Fees.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../bloc/Fees_bloc.dart';
import '../bloc/Fees_state.dart';
import '../widgets/form_fees_widget.dart';

class AddFeesPage extends StatelessWidget{
  final Fees? feesData;

  const AddFeesPage({Key? key, this.feesData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:this.feesData==null? Text(S.of(context).AddTheFeesOfClinic):Text(S.of(context).UpdateTheFeesOfClinic),
      ),
      body: appBody(context),
    );
  }
  Widget appBody(BuildContext context){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child:
        BlocConsumer<AddUpdateGetFeesBloc, AddUpdateGetFeesState>(
          listener: (context, state){
            if (state is MessageAddUpdateGetFeesState){
              SnackBarMessage().showSuccesSnackBar(message: state.message, context: context);
              Navigator.pop(context);
            }else if (state is ErrorFeesState){
              SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state){
            if (state is LoadingFeesState){
              return LoadingWidget();
            }
        return FormFeesWidget(feesData: this.feesData);

          },

        ),
      ),
    );
  }

}