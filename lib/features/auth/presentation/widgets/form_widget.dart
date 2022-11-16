import 'package:clinic/features/auth/presentation/bloc/login_bloc.dart';
import 'package:clinic/features/auth/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/login.dart';

class FormWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FormWidgetState();
  }
}

class _FormWidgetState extends State<FormWidget>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
              onPressed: validateFormThenUpdateOrAddPost,
              icon: Icon(Icons.login),
              label: Text('Login')
          )
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
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