import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/StrogeData/hive.dart';
import '../../domain/entities/user.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

@immutable
class FormUserWidget extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool isItAdd;
  FormUserWidget({Key? key, required this.isItAdd}) : super(key: key);

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
              controller: _userNameController,
              validator: (val) =>this.isItAdd==false?null: val!.isEmpty ? 'must add the name of user' : null,
              decoration: InputDecoration(hintText: 'User Name'),
              minLines: 2,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) =>this.isItAdd==false?null: val!.isEmpty ? 'must add the email of user' : null,
              decoration: InputDecoration(hintText: 'Email'),
              minLines: 2,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:this.isItAdd==true?TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              validator: (val) =>this.isItAdd==false?null: val!.isEmpty ? 'must add the password of user' : null,
              decoration: InputDecoration(hintText: 'Password'),
              obscureText:true

            ):Container(),
          ),
          ElevatedButton.icon(
              onPressed:()=> validateFormThenUpdateOrAddPost(context, this.isItAdd),
              icon: Icon(Icons.add),
              label: Text(isItAdd==true?'Add user':'Update user')
          )
        ],
      ),
    );
  }

  Future<void> validateFormThenUpdateOrAddPost(BuildContext context, bool isItAdd) async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {
        final user = User(
            userName: _userNameController.text.toString(),
            email: _emailController.text.toString(),
            password: _passwordController.text.toString()
        );
        if (isItAdd==true) {
          BlocProvider.of<AddUpdateUserBloc>(context)
              .add(AddUserEvent(user: user));
        }else{
          var tasksBox = await Hive.openBox<Person>('user');
          BlocProvider.of<AddUpdateUserBloc>(context)
              .add(UpdateUserEvent(user: user,
              userId: int.parse(tasksBox.get(0)!.pk??0.toString())));
        }
      } catch (e){
        print(e);
      }


    }
  }
}