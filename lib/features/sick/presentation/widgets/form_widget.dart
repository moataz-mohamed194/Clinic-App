import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/sick.dart';
import '../bloc/add_sick_bloc.dart';
import '../bloc/add_sick_event.dart';

class FormSickWidget extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
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
              minLines: 2,
              maxLines: 2,
            ),
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
            typeOfStatment: 'A',
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