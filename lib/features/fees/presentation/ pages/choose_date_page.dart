import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/string/app_color.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/general_app_bar.dart';
import 'get_fees.dart';

class ChooseDatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final bool isItDay;

  ChooseDatePage({Key? key, required this.isItDay}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: generalAppBar(context: context, title: 'Choose the date',),

        // AppBar(
        //   leading: IconButton(onPressed: (){
        //     Navigator.pop(context);
        //   }, icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black,)),
        //   title: Text(
        //     'Choose the date',
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
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
                      hintText: 'Choose the date',
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
                    dateLabelText: 'Choose the date',
                    lastDate: DateTime(2100),
                    // initialValue:'2022-05-10',
                    // readOnly: true,
                    controller: _dateController,
                    onChanged: (val) => print(val),
                    validator: (val) {
                      if (val == null) {
                        return 'must choose day';
                      }
                      return null;
                    },
                    onSaved: (val) => print(val),
                  )),
              ButtonWidget(
                textColor: Colors.white,
                boarderColor: Colors.transparent,
                text: 'Done',
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
