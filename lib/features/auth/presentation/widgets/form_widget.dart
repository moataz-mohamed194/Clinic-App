import 'package:clinic/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/login.dart';
import '../../../../core/string/app_color.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../../generated/l10n.dart';
import '../bloc/check_box_cubit.dart';
import '../bloc/eyes_cubit.dart';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FormWidget({required context}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              S.of(context).LoginToYourAccount,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              controler: _emailController,
              validatorTextField: (val) =>
                  val!.isEmpty ? S.of(context).MustAddTheEmailOfUser : null,
              leftWidget: Icon(Icons.email_outlined),
              hintText: S.of(context).Email,
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<EyesCubit, bool>(builder: (context, state) {
              return TextFieldWidget(
                controler: _passwordController,
                validatorTextField: (val) =>
                    val!.isEmpty ? S.of(context).MustAddThePassword : null,
                leftWidget: Icon(Icons.lock_outlined),
                hintText: S.of(context).Password,
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
                            ),
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(S.of(context).RememberMe),
                  ],
                ),
              );
            }),
            ButtonWidget(
              textColor: Colors.white,
              boarderColor: Colors.transparent,
              text: S.of(context).SignIn,
              action: () {
                validateFormThenUpdateOrAddPost(context);
              },
              backgroundColor: AppColors.mainColor,
              marginHeight: 10,
              marginWidth: 0,
            ),
          ],
        ),
      ),
    );
  }

  void validateFormThenUpdateOrAddPost(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final login = Login(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString(),
      );

      BlocProvider.of<LoginBloc>(context).add(LoginMethodEvent(
          login: login, stayLogin: context.read<CheckBoxCubit>().state));
    }
  }
