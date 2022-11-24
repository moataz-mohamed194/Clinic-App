import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/sick.dart';
import '../bloc/add_sick_bloc.dart';
import '../bloc/add_sick_event.dart';

@immutable
class FormSickWidget extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(text: DateTime.now().toString());
  final TextEditingController _typeOfStatementController = TextEditingController(text: DateTime.now().toString());

  final List dropdownItemList = [
    {'label': 'Consultation', 'value': 'A'}, // label is required and unique
    {'label': 'Statement', 'value': 'B'}
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _titleController,
              validator: (val) => val!.isEmpty ? 'must add the name of sick' : null,
              decoration: InputDecoration(hintText: 'Name'),
              minLines: 2,
              maxLines: 2,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'must add the phone number' :
                val.length>11 || val.length<11?'your number not right': null,
              decoration: InputDecoration(hintText: 'phone number'),

            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:DateTimePicker(
              type: DateTimePickerType.date,
              dateMask: 'yyyy-MM-dd',
              controller: _dateController,
              firstDate: DateTime(2000),
              decoration:InputDecoration(
                  hintText:'Date of Statement'),
              dateLabelText:'Choose the date',
              lastDate: DateTime(2100),
              onChanged: (value) {
                _dateController.text = '$value'.toString();
              },
              validator: (val) {
                if(val == null){
                  return 'must choose date';
                }
                return null;
              },
            )
          ),
          CoolDropdown(
            dropdownList: dropdownItemList,
            onChange: (val) {
              _typeOfStatementController.text = val['value'];
            },
            resultBD: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                ),
              ],
            ),
            resultWidth:MediaQuery.of(context).size.width-60,
            placeholder: 'Type of Statement',

          ),
          ElevatedButton.icon(
              onPressed:()=> validateFormThenUpdateOrAddPost(context),
              icon: Icon(Icons.add),
              label: Text('Add sick')
          )
        ],
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
            time:_dateController.text.toString()
        );
        BlocProvider.of<AddUpdateGetSickBloc>(context)
            .add(AddSickEvent(sick: sick));
      }
      catch (e){
        print(e);
      }


    }
  }
}