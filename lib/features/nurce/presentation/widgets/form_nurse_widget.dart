import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/Nurse.dart';
import '../bloc/Nurse_bloc.dart';
import '../bloc/Nurse_event.dart';


class FormNurseWidget extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstPhoneNumberController = TextEditingController();
  final TextEditingController _secondPhoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'must add the email of Nurse' : null,
              decoration: InputDecoration(hintText: 'Nurse Email'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: 'Name'),
              validator: (val) => val!.isEmpty ? 'must add the name of Nurse' : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:TextFormField(
              keyboardType: TextInputType.number,
              controller: _firstPhoneNumberController,
              validator: (val) => val!.isEmpty ? 'must add the phone number' :
              val.length>11 || val.length<11?'your number not right': null,
              decoration: InputDecoration(hintText: 'phone number'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:TextFormField(
              keyboardType: TextInputType.number,
              controller: _secondPhoneNumberController,
              validator: (val) => val!.isEmpty ? null :
              val.length>11 || val.length<11?'your number not right': null,
              decoration: InputDecoration(hintText: 'phone number'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:TextFormField(
              keyboardType: TextInputType.name,
              controller: _descriptionController,
              validator: (val) => val!.isEmpty ? 'must add the description' :
               null,
              decoration: InputDecoration(hintText: 'Description'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:TextFormField(
              keyboardType: TextInputType.name,
              controller: _passwordController,
              validator: (val) => val!.isEmpty ? 'must add the password' :
              val.length<12 ?'your password must be longer than 12': null,
              decoration: InputDecoration(hintText: 'Password'),

            ),
          ),



          ElevatedButton.icon(
              onPressed:()=> validateFormAddNurse(context),
              icon: Icon(Icons.add),
              label: Text('Add New Nurse')
          )
        ],
      ),
    );
  }

  void validateFormAddNurse(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      // try {
        final nurse = Nurse(
          description: _descriptionController.text,
          firstPhoneNumber: int.parse(_firstPhoneNumberController.text),
          password: _passwordController.text,
          email: _emailController.text,
          userName: _nameController.text,
          secondPhoneNumber: _secondPhoneNumberController.text
        );
        print(nurse);
        BlocProvider.of<AddGetNurseBloc>(context)
            .add(AddNurseEvent(nurse: nurse));
      // }
      // catch (e){
      //   print(e);
      // }


    }
  }

}