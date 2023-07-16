import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../bloc/doctor_bloc.dart';
import '../bloc/doctor_state.dart';
import '../widgets/form_doctor_widget.dart';

class AddNewDoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(
        context: context,
        title: S.of(context).AddDoctorData,
      ),
      body: appBody(context),
    );
  }

  Widget appBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddGetDoctorBloc, AddGetDoctorState>(
          listener: (context, state) {
            if (state is MessageAddGetDoctorState) {
              SnackBarMessage()
                  .showSuccesSnackBar(message: state.message, context: context);
              Navigator.pop(context);
            } else if (state is ErrorDoctorState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingDoctorState) {
              return LoadingWidget();
            }
            return FormDoctorWidget();
          },
        ),
      ),
    );
  }
}
