import 'package:clinic/features/sick/presentation/%20pages/get_all_sicks.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            trailing: typeOfLogin == 'doctor'?IconButton(icon: Icon(Icons.call_made),
              onPressed: () => _onUpdate(context, sick[index].id),):Text(''),
            dense: true,
            minVerticalPadding: 1.0,
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
}