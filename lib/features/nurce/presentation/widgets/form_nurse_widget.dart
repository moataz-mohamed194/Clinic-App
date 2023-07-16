import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/Nurse.dart';
import '../../../../generated/l10n.dart';
import '../bloc/Nurse_bloc.dart';
import '../bloc/Nurse_event.dart';

class FormNurseWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstPhoneNumberController =
      TextEditingController();
  final TextEditingController _secondPhoneNumberController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) =>
                  val!.isEmpty ? S.of(context).MustAddTheEmailOfNurse : null,
              decoration: InputDecoration(hintText: S.of(context).Email),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: S.of(context).Name),
              validator: (val) =>
                  val!.isEmpty ? S.of(context).MustAddTheNameOfNurse : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _firstPhoneNumberController,
              validator: (val) => val!.isEmpty
                  ? S.of(context).MustAddThePhoneNumber
                  : val.length > 11 || val.length < 11
                      ? S.of(context).YourNumberNotRight
                      : null,
              decoration: InputDecoration(hintText: S.of(context).PhoneNumber),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _secondPhoneNumberController,
              validator: (val) => val!.isEmpty
                  ? null
                  : val.length > 11 || val.length < 11
                      ? S.of(context).YourNumberNotRight
                      : null,
              decoration: InputDecoration(hintText: S.of(context).PhoneNumber),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: _descriptionController,
              validator: (val) =>
                  val!.isEmpty ? S.of(context).MustAddTheDescription : null,
              decoration: InputDecoration(hintText: S.of(context).Description),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: _passwordController,
              validator: (val) => val!.isEmpty
                  ? S.of(context).MustAddThePassword
                  : val.length < 12
                      ? S.of(context).YourPasswordMustBeLongerThan12
                      : null,
              decoration: InputDecoration(hintText: S.of(context).Password),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () => validateFormAddNurse(context),
              icon: Icon(Icons.add),
              label: Text(S.of(context).AddNewNurse))
        ],
      ),
    );
  }

  void validateFormAddNurse(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final nurse = Nurse(
          description: _descriptionController.text,
          firstPhoneNumber: int.parse(_firstPhoneNumberController.text),
          password: _passwordController.text,
          email: _emailController.text,
          userName: _nameController.text,
          secondPhoneNumber: _secondPhoneNumberController.text);
      BlocProvider.of<AddGetNurseBloc>(context)
          .add(AddNurseEvent(nurse: nurse));
    }
  }
}
