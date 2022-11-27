import 'package:clinic/features/sick/presentation/%20pages/get_all_sicks.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ pages/add_report_of_sick.dart';
import '../../ domain/entities/sick.dart';


class SickListWidget extends StatelessWidget{
  final List<Sick> sick;
  final String? typeOfLogin;

  const SickListWidget({Key? key, required this.sick, this.typeOfLogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: sick.length,

        itemBuilder: (context, index){
          return ListTile(
            leading: Text('${index+1}'),
            title: Text(sick[index].name),
            subtitle: Text(sick[index].phoneNumber.toString()),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            trailing: Column(
              children: [

                typeOfLogin == 'doctor'?IconButton(icon: Icon(Icons.add ),
                  onPressed: () => _onUpdate(context, sick[index].id),)
                    :typeOfLogin == 'nurse'?IconButton(icon: Icon(Icons.mobile_friendly),
                  onPressed: () => _onUpdateAsEntered(context, sick[index].id),):Text(''),
              ],
            ),
            dense: true,
            minVerticalPadding: 2.0,
            onTap: typeOfLogin == 'doctor'?(){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AddReportOfSickPage(idOfSick: sick[index].id)));
            }:null,
          );
        },
        separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
  _onUpdate(BuildContext context,sickId) async {
    try {
      BlocProvider.of<AddUpdateGetSickBloc>(context)
          .add(UpdateSickEvent(sickId: sickId ));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => GetAllSicksPage()), (route) => false);
    }
    catch(e){
      print(e);
    }
  }
  _onUpdateAsEntered(BuildContext context,sickId) async {
    try {
      BlocProvider.of<AddUpdateGetSickBloc>(context)
          .add(UpdateSickAsEnteredEvent(sickId: sickId ));
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => GetAllSicksPage()));
    }
    catch(e){
      print(e);
    }
  }
}