import '../../../../core/widgets/date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/string/app_color.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../../../../generated/l10n.dart';
import 'get_fees.dart';

class ChooseDatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final bool isItDay;

  ChooseDatePage({Key? key, required this.isItDay}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: generalAppBar(
          context: context,
          title: S.of(context).ChooseTheDate,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: DateTimePicker(
                    decoration: InputDecoration(
                        hintText: S.of(context).ChooseTheDate,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        prefixIcon: Icon(Icons.date_range),
                        fillColor: Colors.grey.shade200,
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15.sp)),
                    type: DateTimePickerType.date,
                    dateMask: 'dd/MM/yyyy',
                    firstDate: DateTime(2000),
                    dateLabelText: S.of(context).ChooseTheDate,
                    lastDate: DateTime(2100),
                    controller: _dateController,
                    onChanged: (val) => print(val),
                    validator: (val) {
                      if (val == null) {
                        return S.of(context).MustChooseDay;
                      }
                      return null;
                    },
                    onSaved: (val) => print(val),
                  )),
              ButtonWidget(
                textColor: Colors.white,
                boarderColor: Colors.transparent,
                text: S.of(context).Done,
                action: () {
                  goToPages(context);
                },
                backgroundColor: AppColors.mainColor,
                marginHeight: 10,
                marginWidth: 30,
              ),
              // ElevatedButton.icon(
              //     onPressed:()=> ,
              //     icon: Icon(Icons.done),
              //     label: Text('Done')
              // )
            ],
          ),
        ));
  }

  void goToPages(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => GetAllFeesPage(
                    isItDay: isItDay,
                    date: _dateController.text,
                  )));

      // Navigator.push(context, MaterialPageRoute(builder: (_)=>
      //       GetAllFeesPage(isItDay:isItDay, date: _dateController.text,)));
    }
  }
}
