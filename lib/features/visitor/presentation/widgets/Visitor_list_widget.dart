import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ pages/get_all_visitors.dart';
import '../../ domain/entities/visitor.dart';
import '../bloc/add_update_visitor/add_update_visitor_bloc.dart';

visitorListWidget ({required List<Visitor> visitor,String? typeOfLogin}){

  // const VisitorListWidget({Key? key, required this.visitor, this.typeOfLogin}) : super(key: key);
  // @override
  // Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
          itemCount: visitor.length,

          itemBuilder: (context, index){
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: visitor[index].approved==false ?Colors.red:Colors.green,
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
                title: Text(visitor[index].name),
                subtitle: Text(visitor[index].reasonOfVisitor),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                trailing: typeOfLogin == 'doctor'?IconButton(icon: Icon(Icons.call_made), onPressed: () => _onUpdate(context, visitor[index].id),):Text(''),
                dense: true,
                // tileColor:visitor[index].approved==false ?Colors.red:Colors.green,
                minVerticalPadding: 1.0,
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(thickness: 1),
      ),
    );
  }
  _onUpdate(BuildContext context,visitorId) async {
    try {
      BlocProvider.of<AddUpdateVisitorBloc>(context)
          .add(UpdateVisitorEvent(visitorId:visitorId ));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => GetAllVisitors()), (route) => false);
    }
    catch(e){
      print(e);
    }
  }
