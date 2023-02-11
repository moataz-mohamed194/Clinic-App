import 'package:clinic/features/fees/presentation/bloc/Fees_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ pages/add_fees.dart';
import '../ pages/get_fees.dart';
import '../../ domain/entities/Fees.dart';
import '../bloc/Fees_bloc.dart';


class FeesListWidget extends StatelessWidget{
  final List<Fees> fees;
  final bool isItDay;
  final String date;

  const FeesListWidget({Key? key, required this.fees, required this.isItDay,
    required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: fees.length,

      itemBuilder: (context, index){
        return ListTile(
          leading: Text('${index+1}'),
          title: Text("${fees[index].type}"),
          subtitle: Text('${fees[index].price.toString()}             ${fees[index].time.toString()}'),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          trailing: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width/4,
              height: 48,
              // padding: const EdgeInsets.symmetric(vertical: 4.0),
              // alignment: Alignment.center,
              child: Row(children: [

                IconButton(icon: Icon(Icons.edit),
                  onPressed: () => _onUpdate(context, fees[index]),),
                IconButton(icon: Icon(Icons.close,color: Colors.red,),
                  onPressed: () => _onDelete(context, fees[index].id),)
              ],),
            ),
          ),
          dense: false,
          minVerticalPadding: 1.0,
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }


  _onUpdate(BuildContext context,fees) async {
    try {
      BlocProvider.of<AddUpdateGetFeesBloc>(context)
          .add(UpdateFeesEvent(fees: fees));
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AddFeesPage(feesData:fees)));
    }
    catch(e){
      print(e);
    }
  }

  _onDelete(BuildContext context,fees) async {
    try {
      BlocProvider.of<AddUpdateGetFeesBloc>(context)
          .add(DeleteFeesEvent(feesId: fees ));
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => GetAllFeesPage(isItDay:this.isItDay, date: this.date)));
    }
    catch(e){
      print(e);
    }
  }
}