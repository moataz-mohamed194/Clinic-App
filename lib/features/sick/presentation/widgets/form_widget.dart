import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ domain/entities/sick.dart';
import '../../../../core/string/app_color.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../../generated/l10n.dart';
import '../bloc/add_sick_bloc.dart';
import '../bloc/add_sick_event.dart';

@immutable
class FormSickWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(text: DateTime.now().toString());
  final TextEditingController _typeOfStatementController =
      TextEditingController(text: DateTime.now().toString());

  final List dropdownItemList = [
    {'label': 'Consultation', 'value': 'A'}, // label is required and unique
    {'label': 'Statement', 'value': 'B'}
  ];

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
                    val!.isEmpty ? S.of(context).MustAddTheNameOfSick : null,
                hintText: S.of(context).Name,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFieldWidget(
                controler: _phoneNumberController,
                keyboardType: TextInputType.number,
                validatorTextField: (val) => val!.isEmpty
                    ? S.of(context).MustAddThePhoneNumber
                    : val.length > 11 || val.length < 11
                        ? S.of(context).YourNumberNotRight
                        : null,
                hintText: S.of(context).PhoneNumber,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'yyyy-MM-dd',
                  decoration: InputDecoration(
                      hintText: S.of(context).DateOfStatement,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.date_range),
                      fillColor: Colors.grey.shade200,
                      hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  controller: _dateController,
                  firstDate: DateTime(2000),
                  dateLabelText: S.of(context).ChooseTheDate,
                  lastDate: DateTime(2100),
                  onChanged: (value) {
                    _dateController.text = '$value'.toString();
                  },
                  validator: (val) {
                    if (val == null) {
                      return S.of(context).MustChooseDate;
                    }
                    return null;
                  },
                )),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: CoolDropdown(
                dropdownList: dropdownItemList,
                onChange: (val) {
                  _typeOfStatementController.text = val['value'];
                },
                resultBD: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.transparent, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                    ),
                  ],
                ),
                resultWidth: MediaQuery.of(context).size.width,
                placeholder: S.of(context).TypeOfStatement,
              ),
            ),
            // ElevatedButton.icon(
            //     onPressed:()=> validateFormThenUpdateOrAddPost(context),
            //     icon: Icon(Icons.add),
            //     label: Text('Add sick')
            // )
            ButtonWidget(
              textColor: Colors.white,
              boarderColor: Colors.transparent,
              text: S.of(context).AddSick,
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
        final sick = Sick(
            id: 0,
            name: _titleController.text.toString(),
            phoneNumber: int.parse(_phoneNumberController.text),
            typeOfStatment: _typeOfStatementController.text.toString(),
            time: _dateController.text.toString());
        BlocProvider.of<AddUpdateGetSickBloc>(context)
            .add(AddSickEvent(sick: sick));
      } catch (e) {
        print(e);
      }
    }
  }
}
