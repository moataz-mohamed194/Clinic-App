import 'package:clinic/features/clinic/presentation/bloc/actions_clinic_bloc.dart';
import 'package:clinic/features/clinic/presentation/bloc/actions_clinic_event.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/Clinic.dart';


class FormClinicWidget extends StatelessWidget{
  final Clinic? clinic;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _timeOfVacationsController = TextEditingController();
  TextEditingController _fromTimesController = TextEditingController();
  TextEditingController _toTimeController = TextEditingController();

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
            DateTimeFormField(

                decoration: InputDecoration(
                    hintText:  clinic!.fromTime
                ),
                mode: DateTimeFieldPickerMode.time,
                autovalidateMode: AutovalidateMode.always,

                onDateSelected: (DateTime value) {
                  print(clinic!.fromTime);
                  print(value);
                  if(clinic!.fromTime != '${value.hour}:${value.minute}:${value.second}'){
                    _fromTimesController.text = '${value.hour}:${value.minute}:${value.second}'.toString();
                  }else{
                    _fromTimesController.text = clinic!.fromTime.toString();
                  }
                },
                use24hFormat:true
              // initialValue:DateTime.parse(clinic!.fromTime) != null? DateTime.parse(clinic!.fromTime):null
            ):
            DateTimeFormField(
            decoration: InputDecoration(
              hintText: 'Start time'
            ),
            mode: DateTimeFieldPickerMode.time,
            autovalidateMode: AutovalidateMode.always,
            validator: (DateTime? e) {

              return e?.hour ==null ? 'must add the Start time of clinic':'';
            },
              onDateSelected: (DateTime value) {
                  _fromTimesController.text = '${value.hour}:${value.minute}'.toString();

              },
              use24hFormat:true
            // initialValue:DateTime.parse(clinic!.fromTime) != null? DateTime.parse(clinic!.fromTime):null
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:clinic !=null?
              DateTimeFormField(
                decoration: InputDecoration(
                    hintText:clinic?.toTime),
                mode: DateTimeFieldPickerMode.time,
                onDateSelected: (DateTime value) {
                  print(clinic!.fromTime);
                  print(value);
                  if(clinic!.toTime != '${value.hour}:${value.minute}:${value.second}'){
                    _fromTimesController.text = '${value.hour}:${value.minute}:${value.second}'.toString();
                  }else{
                    _fromTimesController.text = clinic!.toTime.toString();
                  }
                },
                use24hFormat:true,

            )
              : DateTimeFormField(
                decoration: InputDecoration(
                hintText:clinic?.toTime != null? clinic!.toTime:'End time'),
                mode: DateTimeFieldPickerMode.time,
                validator: (DateTime? e) {
                  return
                    e?.hour!=null ? null:'must add the end time of clinic';
                },
                onDateSelected: (DateTime value) {
                  DateTime old_date = DateTime.parse(clinic!.toTime);
                  if(old_date.hour == value.hour && old_date.minute == value.minute){
                    _toTimeController.text = '${old_date.hour}:${old_date.minute}'.toString();
                  }else{
                    _toTimeController.text = '${value.hour}:${value.minute}'.toString();
                  }
                },
                use24hFormat:true
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
    print(oldClinic);
    _addressController.text==''?print(oldClinic!.addrees):print(_addressController.text);
    _noteController.text==''?print(oldClinic?.note):print(_noteController.text);
    _fromTimesController.text==''?print(oldClinic!.fromTime):print(_fromTimesController.text);
    _toTimeController.text==''?print(oldClinic!.toTime):print(_toTimeController.text);
    _timeOfVacationsController.text==''?print(oldClinic!.timeOfVacation):print(_timeOfVacationsController.text);
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