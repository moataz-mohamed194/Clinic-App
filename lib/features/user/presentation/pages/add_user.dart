import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/string/app_color.dart';
import '../../../../core/string/app_icons.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/widget_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';
import '../widgets/form_widget.dart';

class AddUserPage extends StatelessWidget {
  final bool isItAdd;

  const AddUserPage({Key? key, required this.isItAdd}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(context: context),
      body: appBody(context),
    );
  }

  Widget appBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(AppIcons.iconHealthCare),
              flex: 1,
            ),
            Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: BlocConsumer<AddUpdateUserBloc, AddUpdateUserState>(
                    listener: (context, state) {
                      if (state is MessageAddUpdateUserState) {
                        SnackBarMessage().showSuccesSnackBar(
                            message: state.message, context: context);
                        Navigator.pop(context);
                      } else if (state is ErrorUsersState) {
                        SnackBarMessage().showErrorSnackBar(
                            message: state.message, context: context);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingAddUpdateVisitorState) {
                        return LoadingWidget();
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FormUserWidget(isItAdd: this.isItAdd),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.shade300,
                              )),
                              Text(
                                '    ${S.of(context).OrContinueWith}    ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Expanded(
                                  child: Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.shade300,
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60,
                                  // width: 10,//double.minPositive,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.0,
                                        style: BorderStyle.solid), //Border.all
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Image(
                                    image: AssetImage(AppIcons.iconFaceBook),
                                    width: 10,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 60,
                                  width: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.0,
                                        style: BorderStyle.solid), //Border.all
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Image.asset(AppIcons.iconGoogle),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 60,
                                  width: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.0,
                                        style: BorderStyle.solid), //Border.all
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Image.asset(AppIcons.iconAppleLogo),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(S.of(context).AlreadyHaveAnAccount,
                                style: TextStyle(color: Colors.grey),
                              ),
                              InkWell(
                                child: Text(S.of(context).SignIn,
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    // decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
