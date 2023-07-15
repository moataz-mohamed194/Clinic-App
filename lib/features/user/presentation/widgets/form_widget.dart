import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/StrogeData/hive.dart';
import '../../../../core/string/app_color.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../auth/presentation/bloc/check_box_cubit.dart';
import '../../../auth/presentation/bloc/eyes_cubit.dart';
import '../../domain/entities/user.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

@immutable
class FormUserWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool isItAdd;
  FormUserWidget({Key? key, required this.isItAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Register to Your Account',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              controler: _userNameController,
              validatorTextField: (val) => this.isItAdd == false
                  ? null
                  : val!.isEmpty
                      ? 'must add the name of user'
                      : null,
              leftWidget: Icon(Icons.person_outline_outlined),
              hintText: 'User Name',
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              controler: _emailController,
              validatorTextField: (val) => this.isItAdd == false
                  ? null
                  : val!.isEmpty
                      ? 'must add the email of user'
                      : null,
              leftWidget: Icon(Icons.email_outlined),
              hintText: 'Email',
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<EyesCubit, bool>(builder: (context, state) {
              return TextFieldWidget(
                controler: _passwordController,
                validatorTextField: (val) =>
                    val!.isEmpty ? 'must add the password' : null,
                leftWidget: Icon(Icons.lock_outlined),
                hintText: 'password',
                obscureText: state,
                rightWidget: InkWell(
                  child: state == true
                      ? Icon(Icons.remove_red_eye_outlined)
                      : Icon(Icons.panorama_fish_eye),
                  onTap: () {
                    context.read<EyesCubit>().changeEyes();
                  },
                ),
              );
            }),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<CheckBoxCubit, bool>(builder: (context, state) {
              return InkWell(
                onTap: () {
                  context.read<CheckBoxCubit>().changeCheckBoxCubit();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.mainColor, width: 3),
                        color: state ? AppColors.mainColor : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: state
                          ? Icon(
                              Icons.check,
                              size: 20.0,
                              color: Colors.white,
                            )
                          : Icon(
                              null,
                              // size: 30.0,
                            ),
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Remember me'),
                  ],
                ),
              );
            }),
            SizedBox(
              height: 10,
            ),
            ButtonWidget(
              textColor: Colors.white,
              boarderColor: Colors.transparent,
              text: isItAdd == true ? 'Sign up' : 'Update user',
              action: () =>
                  validateFormThenUpdateOrAddPost(context, this.isItAdd),
              backgroundColor: AppColors.mainColor,
              marginHeight: 10,
              marginWidth: 0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validateFormThenUpdateOrAddPost(
      BuildContext context, bool isItAdd) async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {
        final user = User(
            userName: _userNameController.text.toString(),
            email: _emailController.text.toString(),
            password: _passwordController.text.toString());
        if (isItAdd == true) {
          BlocProvider.of<AddUpdateUserBloc>(context)
              .add(AddUserEvent(user: user));
        } else {
          var tasksBox = await Hive.openBox<Person>('user');
          BlocProvider.of<AddUpdateUserBloc>(context).add(UpdateUserEvent(
              user: user,
              userId: int.parse(tasksBox.get(0)!.pk ?? 0.toString())));
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
