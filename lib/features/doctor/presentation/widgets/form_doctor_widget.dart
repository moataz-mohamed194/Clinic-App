import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/Doctor.dart';
import '../../../../core/string/app_color.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../bloc/doctor_bloc.dart';
import '../bloc/doctor_event.dart';

class FormDoctorWidget extends StatelessWidget {
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
                controler: _emailController,
                keyboardType: TextInputType.emailAddress,
                validatorTextField: (val) =>
                    val!.isEmpty ? 'must add the email of doctor' : null,
                hintText: 'Doctor',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFieldWidget(
                controler: _nameController,
                keyboardType: TextInputType.name,
                validatorTextField: (val) =>
                    val!.isEmpty ? 'must add the name of doctor' : null,
                hintText: 'Name',
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
                    ? 'must add the phone number'
                    : val.length > 11 || val.length < 11
                        ? 'your number not right'
                        : null,
                hintText: 'Phone Number',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFieldWidget(
                controler: _descriptionController,
                keyboardType: TextInputType.name,
                validatorTextField: (val) =>
                    val!.isEmpty ? 'must add the description' : null,
                hintText: 'Description',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFieldWidget(
                controler: _passwordController,
                keyboardType: TextInputType.name,
                validatorTextField: (val) => val!.isEmpty
                    ? 'must add the password'
                    : val.length > 12
                        ? 'your password must be longer than 12'
                        : null,
                hintText: 'Password',
              ),
            ),
            ButtonWidget(
              textColor: Colors.white,
              boarderColor: Colors.transparent,
              text: 'Add New Doctor',
              action: () {
                validateFormAddDoctor(context);
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

  void validateFormAddDoctor(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {
        final doctor = Doctor(
            description: _descriptionController.text,
            phoneNumber: int.parse(_phoneNumberController.text),
            password: _passwordController.text,
            email: _emailController.text,
            name: _nameController.text);
        BlocProvider.of<AddGetDoctorBloc>(context)
            .add(AddDoctorEvent(doctor: doctor));
      } catch (e) {
        print(e);
      }
    }
  }
}
