import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';
import 'package:clinic/features/visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/string/app_color.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../../generated/l10n.dart';

class FormVisitorWidget extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFieldWidget(
                controler: _titleController,
                keyboardType: TextInputType.text,
                validatorTextField: (val) =>
                val!.isEmpty ? S.of(context).MustAddTheNameOfVisitor : null,
                hintText: S.of(context).Name,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFieldWidget(
                controler: _bodyController,
                keyboardType: TextInputType.text,
                validatorTextField: (val) =>
                val!.isEmpty ? S.of(context).MustAddTheReasonOfVisitor : null,
                hintText: 'Reason',
              ),
            ),

            ButtonWidget(
              textColor: Colors.white,
              boarderColor: Colors.transparent,
              text: S.of(context).AddVisitor,
              action: () {
                validateFormThenUpdateOrAddPost(context);
              },
              backgroundColor: AppColors.mainColor,
              marginHeight: 10,
              marginWidth: 30,
            ),

          ],
        ),
      ),
    );
  }

  void validateFormThenUpdateOrAddPost(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {
        final now = DateTime.now();
        final visitor = Visitor(
            id: 0,
            addedBy: 5,
            reasonOfVisitor: _bodyController.text.toString(),
            addedByName: '',
            approved: false,
            name: _titleController.text.toString(),
            time: '${now.year}-${now.month}-${now.day}');
        BlocProvider.of<AddUpdateVisitorBloc>(context)
            .add(AddVisitorEvent(visitor: visitor));
      }
      catch (e){
        print(e);
      }


    }
  }
}