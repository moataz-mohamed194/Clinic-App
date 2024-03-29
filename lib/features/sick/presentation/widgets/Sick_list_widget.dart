import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../ pages/add_report_of_sick.dart';
import '../../ domain/entities/sick.dart';
import '../../../../core/bloc/socket/socket_bloc.dart';

sickListWidget({required Sick sick, String? typeOfLogin, required context}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child:
    // ListView.separated(
    //   itemCount: sick.length,
    //   itemBuilder: (context, index) {
    //     return
          Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Container(
              child: Text(
                '${sick.id}',
                style: TextStyle(fontSize: 19),
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.center,
              width: 30.w,
              height: MediaQuery.of(context).size.height,
            ),
            title: Text(sick.name),
            dense: true,
            onTap: typeOfLogin == 'Doctor'
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            AddReportOfSickPage(idOfSick: sick.id)));
                  }
                : null,
            minVerticalPadding: 2.0,
            subtitle: Text(sick.phoneNumber.toString()),
            trailing: Column(
              children: [

                typeOfLogin == 'Doctor'
                    ? IconButton(
                        icon: Icon(Icons.mobile_friendly),
                        onPressed: () => _onUpdate(context, sick.id),
                      )
                    : typeOfLogin == 'nurse'&&sick.approved==true?

                Text('')
                        : IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () =>_onUpdateAsEntered(context, sick.id),
                          )

                    ,
              ],
            ),
          ),
        )
    //     ;
    //   },
    //   separatorBuilder: (context, index) => Divider(thickness: 1),
    // ),
  );
}

_onUpdateAsEntered(BuildContext context, sickId) async {
  try {
    BlocProvider.of<AddUpdateGetSickBloc>(context)
        .add(UpdateSickEvent(sickId: sickId));

    context.read<SocketBloc>().sendMessage('{"userType":"nurse","sickId":"$sickId"}');
  } catch (e) {
    print(e);
  }
}

_onUpdate(BuildContext context, sickId) async {
  try {
    BlocProvider.of<AddUpdateGetSickBloc>(context)
        .add(UpdateSickAsEnteredEvent(sickId: sickId));
    context.read<SocketBloc>()        .sendMessage('{"userType":"Doctor","sickId":"$sickId"}');
  } catch (e) {
    print(e);
  }
}
