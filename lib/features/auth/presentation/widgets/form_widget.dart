import 'package:clinic/features/auth/presentation/bloc/login_bloc.dart';
import 'package:clinic/features/auth/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/login.dart';
import '../../../user/presentation/pages/add_user.dart';

class FormWidget extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'must add the email' : null,
              decoration: InputDecoration(hintText: 'Name'),
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              validator: (val) => val!.isEmpty ? 'must add the password' : null,
              decoration: InputDecoration(hintText: 'password'),
              obscureText:true


            ),
          ),
          ElevatedButton.icon(
              onPressed:()=> validateFormThenUpdateOrAddPost(context),
              icon: Icon(Icons.login),
              label: Text('Login')
          ),
          InkWell(
            child: Text('Create Account',
              style: TextStyle(color: Colors.blue,
                decoration: TextDecoration.underline,
              ),),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AddUserPage(isItAdd: true,)));

            },
          ),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      // try {
        final login = Login(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString(),
        );

        BlocProvider.of<LoginBloc>(context)
            .add(LoginMethodEvent(login: login));

    }
  }
}