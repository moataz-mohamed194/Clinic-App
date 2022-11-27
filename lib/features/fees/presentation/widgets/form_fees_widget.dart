import 'package:clinic/features/fees/presentation/bloc/Fees_event.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/Fees.dart';
import '../bloc/Fees_bloc.dart';

class FormFeesWidget extends StatelessWidget{
  final Fees? feesData;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  FormFeesWidget({Key? key, this.feesData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: this.feesData==null?
            TextFormField(
              controller: _titleController,
              validator: (val) => val!.isEmpty ? 'must add the type of fees' : null,
              decoration: InputDecoration(hintText: 'Type'),
            ):
            TextFormField(
              initialValue:this.feesData != null? this.feesData!.type:null,
              validator: (val) => val!.isEmpty ? 'must add the type of fees' : null,
              decoration: InputDecoration(hintText: 'Type'),
              onChanged: (e){
                _titleController.text = e;
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: this.feesData==null?
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _priceController,
              initialValue:this.feesData != null? this.feesData!.price:null,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'must add the price of fees';
                }else{
                  try{
                    int.parse(val);
                    return null;
                  }catch(e){
                    return 'must be numbers';
                  }
                }
               },
              decoration: InputDecoration(hintText: 'price'),
            ):
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: this.feesData!.price,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'must add the price of fees';
                }else{
                  try{
                    int.parse(val);
                    return null;
                  }catch(e){
                    double.parse(val);
                    return 'must be numbers';
                  }
                }
              },
              decoration: InputDecoration(hintText: 'price'),
              onChanged: (e){
                _priceController.text = e;
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child:this.feesData==null?
              DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'dd-MM-yyyy',
                firstDate: DateTime(2000),
                decoration:InputDecoration(
                  hintText:'Date'),
                dateLabelText:'Choose the date',
                lastDate: DateTime(2100),
                // initialValue:'2022-05-10',
                controller: _dateController,
                onChanged: (value) {
                  _dateController.text = '$value'.toString();
                },
                validator: (val) {
                  if(val == null){
                    return 'must choose date of fees';
                  }
                  return null;
                },
              ):
              DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'yyyy-MM-dd',
                initialValue: this.feesData!.time,
                firstDate: DateTime(2000),
                decoration:InputDecoration(
                    hintText:'Date'),
                dateLabelText:'Choose the date',
                lastDate: DateTime(2100),
                onChanged: (value) {
                  _dateController.text = '$value'.toString();
                },
                validator: (val) {
                  if(val == null){
                    return 'must choose date of fees';
                  }
                  return null;
                },
              )
          ),
          ElevatedButton.icon(
              onPressed:()=>this.feesData==null?
                validateFormThenAddFees(context):
                validateFormThenUpdateFees(context, this.feesData),
              icon: Icon(Icons.add),
              label:this.feesData==null? Text('Add Fees'):Text('Update Fees')
          )
        ],
      ),
    );
  }

  void validateFormThenAddFees(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      try {
        final fees = Fees(
            id: 0,
            type: _titleController.text,
            price: _priceController.text,
            time: _dateController.text);
        BlocProvider.of<AddUpdateGetFeesBloc>(context)
            .add(AddFeesEvent(fees: fees));
      }
      catch (e){
        print(e);
      }
    }
  }


  void validateFormThenUpdateFees(BuildContext context, Fees? feesData2) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      try {
        final fees = Fees(
            id: feesData2!.id,
            type: _titleController.text==''?this.feesData!.type:_titleController.text,
            price: _priceController.text==''?this.feesData!.price:_priceController.text,
            time: _dateController.text==''?this.feesData!.time:_dateController.text);
        BlocProvider.of<AddUpdateGetFeesBloc>(context)
            .add(UpdateFeesEvent(fees: fees));
      }
      catch (e){
        print(e);
      }
    }
  }

}