import 'package:clinic/features/clinic/presentation/bloc/actions_clinic_bloc.dart';
import 'package:clinic/features/clinic/presentation/bloc/actions_clinic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/Clinic.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../widgets/form_clinic_widget.dart';

class AddNewClinicDataPage extends StatelessWidget {
  final bool showAddAndEdit;
  final Clinic? clinic;
  const AddNewClinicDataPage(
      {Key? key, required this.showAddAndEdit, this.clinic})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clinic != null
            ? S.of(context).UpdateClinicData
            : S.of(context).AddClinicData),
      ),
      body: appBody(context),
    );
  }

  Widget appBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateGetClinicBloc, AddUpdateGetClinicState>(
          listener: (context, state) {
            if (state is MessageAddUpdateGetClinicState) {
              SnackBarMessage()
                  .showSuccesSnackBar(message: state.message, context: context);
              Navigator.pop(context);
            } else if (state is ErrorClinicState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingClinicState) {
              return LoadingWidget();
            }
            return FormClinicWidget(clinic: this.clinic);
          },
        ),
      ),
    );
  }
}
