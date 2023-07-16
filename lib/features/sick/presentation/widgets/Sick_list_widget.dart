import 'package:clinic/features/sick/presentation/%20pages/get_all_sicks.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ pages/add_report_of_sick.dart';
import '../../ domain/entities/sick.dart';

sickListWidget({required List<Sick> sick, String? typeOfLogin}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: ListView.separated(
      itemCount: sick.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Container(
              child: Text(
                '${index + 1}',
                style: TextStyle(fontSize: 19),
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.center,
              width: 30.w,
              height: MediaQuery.of(context).size.height,
            ),

            title: Text(sick[index].name),
            dense: true,
            onTap: typeOfLogin == 'Doctor'
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            AddReportOfSickPage(idOfSick: sick[index].id)));
                  }
                : null,
            minVerticalPadding: 2.0,
            subtitle: Text(sick[index].phoneNumber.toString()),
            trailing: Column(
              children: [
                typeOfLogin == 'Doctor'
                    ? IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _onUpdate(context, sick[index].id),
                      )
                    : typeOfLogin == 'nurse'
                        ? IconButton(
                            icon: Icon(Icons.mobile_friendly),
                            onPressed: () =>
                                _onUpdateAsEntered(context, sick[index].id),
                          )
                        : Text(''),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    ),
  );
}

_onUpdate(BuildContext context, sickId) async {
  try {
    BlocProvider.of<AddUpdateGetSickBloc>(context)
        .add(UpdateSickEvent(sickId: sickId));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => GetAllSicksPage()), (route) => false);
  } catch (e) {
    print(e);
  }
}

_onUpdateAsEntered(BuildContext context, sickId) async {
  try {
    BlocProvider.of<AddUpdateGetSickBloc>(context)
        .add(UpdateSickAsEnteredEvent(sickId: sickId));
    // Navigator.of(context).pop();
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (_) => GetAllSicksPage()));
  } catch (e) {
    print(e);
  }
  // }
}
