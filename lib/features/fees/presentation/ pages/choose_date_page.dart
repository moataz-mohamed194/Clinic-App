import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'get_fees.dart';

class ChooseDatePage extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final bool isItDay;

  ChooseDatePage({Key? key, required this.isItDay}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose the date'),),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child:DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'dd/MM/yyyy',
                firstDate: DateTime(2000),
                  dateLabelText:'Choose the date',
                lastDate: DateTime(2100),
                // initialValue:'2022-05-10',
                controller: _dateController,
                onChanged: (val) => print(val),
                validator: (val) {
                  if(val == null){
                    return 'must choose day';
                  }
                  return null;
                },
                onSaved: (val) => print(val),
                )
            ),
            ElevatedButton.icon(
                onPressed:()=> goToPages(context),
                icon: Icon(Icons.done),
                label: Text('Done')
            )
          ],
        ),
      )
    );
  }

  void goToPages(BuildContext context){
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      Navigator.push(context, MaterialPageRoute(builder: (_)=> GetAllFeesPage(isItDay:isItDay, date: _dateController.text,)));

      // Navigator.push(context, MaterialPageRoute(builder: (_)=>
      //       GetAllFeesPage(isItDay:isItDay, date: _dateController.text,)));
    }
  }

}