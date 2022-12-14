import 'package:clinic/features/clinic/presentation/bloc/actions_clinic_bloc.dart';
import 'package:clinic/features/clinic/presentation/bloc/actions_clinic_event.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/Clinic.dart';


class FormClinicWidget extends StatelessWidget{
  final Clinic? clinic;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _timeOfVacationsController = TextEditingController();
  final TextEditingController _fromTimesController = TextEditingController();
  final TextEditingController _toTimeController = TextEditingController();

  FormClinicWidget({Key? key, this.clinic}) : super(key: key);
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
            child: this.clinic?.addrees != null?
            TextFormField(

              validator: (val) => val!.isEmpty ? 'must add the address of clinic' : null,
              decoration: InputDecoration(hintText: 'Address'),
              initialValue:this.clinic?.addrees != null?clinic?.addrees:'',
              onChanged: (e){
                _addressController.text = e;
              },

            ):
            TextFormField(
              controller: _addressController,

              validator: (val) => val!.isEmpty ? 'must add the address of clinic' : null,
              decoration: InputDecoration(hintText: 'Address'),


            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: this.clinic?.note !=null ?
            TextFormField(
              // controller: _noteController,
              decoration: InputDecoration(hintText: 'Note'),
              initialValue:this.clinic?.note != null?clinic?.note:'',
              onChanged: (e){
                _noteController.text = e;
              },

            ):
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(hintText: 'Note'),
              // initialValue:this.clinic?.note != null?'00'

            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:this.clinic?.timeOfVacation != null?
            TextFormField(
              // controller: _timeOfVacationsController,
              validator: (val) => val!.isEmpty ? 'must add the days of vacations' : null,
              decoration: InputDecoration(hintText: 'time of vacation'),
                initialValue:this.clinic?.timeOfVacation != null?this.clinic?.timeOfVacation:'',
              onChanged: (e){
                _timeOfVacationsController.text = e;
              },
            ):
            TextFormField(
              controller: _timeOfVacationsController,
              validator: (val) => val!.isEmpty ? 'must add the days of vacations' : null,
              decoration: InputDecoration(hintText: 'time of vacation'),
              // initialValue:this.clinic?.timeOfVacation != null?'00':''

            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:this.clinic != null?
            DateTimePicker(
              type: DateTimePickerType.time,
              initialValue: this.clinic!.fromTime,
              firstDate: DateTime(2000),
              decoration:InputDecoration(
                  hintText:'Date'),
              dateLabelText:'Choose the date',
              lastDate: DateTime(2100),
              onChanged: (value) {
                if(clinic!.fromTime != '$value'){
                  _fromTimesController.text = '$value'.toString();
                }else{
                  _fromTimesController.text = clinic!.fromTime.toString();
                }
              },
              validator: (val) {
                if(val == null){
                  return 'must choose date of fees';
                }
                return null;
              },
            )
            :DateTimePicker(
              type: DateTimePickerType.time,
              firstDate: DateTime(2000),
              decoration:InputDecoration(
                hintText:'Start time'),
              lastDate: DateTime(2100),
              controller: _fromTimesController,
              onChanged: (value) {
                _fromTimesController.text = '$value'.toString();
              },
              validator: (val) {
                if(val == null){
                  return 'must add the Start time of clinic';
                }
                return null;
              },
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:clinic !=null?
              DateTimePicker(
                type: DateTimePickerType.time,
                initialValue: this.clinic!.toTime,
                firstDate: DateTime(2000),
                decoration:InputDecoration(
                  hintText:'Date'),
                dateLabelText:'Choose the date',
                lastDate: DateTime(2100),
                onChanged: (value) {
                  if(clinic!.toTime != '$value'){
                    _toTimeController.text = '$value'.toString();
                  }else{
                    _toTimeController.text = clinic!.toTime.toString();
                  }
                },
                validator: (val) {
                  if(val == null){
                    return 'must choose time';
                  }
                  return null;
                },
              )
              :DateTimePicker(
              type: DateTimePickerType.time,
              firstDate: DateTime(2000),
              decoration:InputDecoration(
                  hintText:'End time'),
              lastDate: DateTime(2100),
              controller: _toTimeController,
              onChanged: (value) {
                _toTimeController.text = '$value'.toString();
              },
              validator: (val) {
                if(val == null){
                  return 'must add the end time of clinic';
                }
                return null;
              },
            )
          ),



          ElevatedButton.icon(
              onPressed:()=> clinic!=null ?validateFormUpdateClinic(context,this.clinic) : validateFormAddClinic(context),
              icon: Icon(Icons.add),
              label: Text(clinic!=null?'Update Clinic Data':'Add New Clinic')
          )
        ],
      ),
    );
  }

  void validateFormAddClinic(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {
        final clinic = Clinic(
          id: 0,
          addrees: _addressController.text,
          note: _noteController.text,
          fromTime: _fromTimesController.text,
          toTime: _toTimeController.text,
          timeOfVacation: _timeOfVacationsController.text,
        );
        BlocProvider.of<AddUpdateGetClinicBloc>(context)
            .add(AddClinicEvent(clinic: clinic));
      }
      catch (e){
        print(e);
      }


    }
  }


  void validateFormUpdateClinic(BuildContext context, Clinic? oldClinic) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      try {
        final clinic = Clinic(
          id: int.parse(oldClinic!.id.toString()),
          addrees:_addressController.text==''?oldClinic!.addrees:_addressController.text,
          note: _noteController.text==''?oldClinic!.note:_noteController.text,
          fromTime: _fromTimesController.text==''?oldClinic!.fromTime:_fromTimesController.text,
          toTime: _toTimeController.text==''?oldClinic!.toTime:_toTimeController.text,
          timeOfVacation:_timeOfVacationsController.text==''?oldClinic!.timeOfVacation:_timeOfVacationsController.text,
        );
        BlocProvider.of<AddUpdateGetClinicBloc>(context)
            .add(UpdateClinicEvent(clinic: clinic));
      }
      catch (e){
        print(e);
      }


    }
  }
}