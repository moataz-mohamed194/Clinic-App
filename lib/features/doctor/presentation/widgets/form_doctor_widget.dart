import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/Doctor.dart';
import '../bloc/doctor_bloc.dart';
import '../bloc/doctor_event.dart';


class FormDoctorWidget extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
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
              validator: (val) => val!.isEmpty ? 'must add the email of doctor' : null,
              decoration: InputDecoration(hintText: 'Doctor'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: 'Name'),
              validator: (val) => val!.isEmpty ? 'must add the name of doctor' : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:TextFormField(
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              validator: (val) => val!.isEmpty ? 'must add the phone number' :
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
              val.length>12 ?'your password must be longer than 12': null,
              decoration: InputDecoration(hintText: 'Password'),

            ),
          ),



          ElevatedButton.icon(
              onPressed:()=> validateFormAddDoctor(context),
              icon: Icon(Icons.add),
              label: Text('Add New Doctor')
          )
        ],
      ),
    );
  }

  void validateFormAddDoctor(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {
        final doctor = Doctor(
          description: _descriptionController.text,
          phoneNumber: int.parse(_phoneNumberController.text),
            password: _passwordController.text,
          email: _emailController.text,
          name: _nameController.text
        );
        BlocProvider.of<AddGetDoctorBloc>(context)
            .add(AddDoctorEvent(doctor: doctor));
      }
      catch (e){
        print(e);
      }


    }
  }

}