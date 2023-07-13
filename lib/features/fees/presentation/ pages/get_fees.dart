import 'package:clinic/features/fees/presentation/bloc/Fees_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../bloc/Fees_bloc.dart';
import '../bloc/Fees_state.dart';
import '../widgets/Fees_list_widget.dart';
import 'add_fees.dart';
import '../../../../core/injection/injection_container.dart' as di;

class GetAllFeesPage extends StatelessWidget{
  final bool isItDay;
  final String date;

  const GetAllFeesPage({Key? key, required this.isItDay,required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fees')),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  Widget _buildBody(){
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: BlocProvider<AddUpdateGetFeesBloc>(
            create: (context) => di.sl<AddUpdateGetFeesBloc>()
              ..add(isItDay == true ?
                GetFeesOfDayEvent(day: this.date):
                GetFeesOfMonthEvent(month: this.date)),
            child: BlocBuilder<AddUpdateGetFeesBloc, AddUpdateGetFeesState>(
              builder: (context, state) {
                if (state is LoadingFeesState){
                  return LoadingWidget();
                }
                else if (state is LoadedFeesState) {
                  return RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: FeesListWidget(fees: state.fees, isItDay:isItDay,
                          date:date));
                }
                else if (state is ErrorFeesState) {
                  return MessageDisplayWidget(message: state.message);
                }
                return LoadingWidget();
              },
            )
        )
    );
  }


  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> AddFeesPage()));
      },
      child: Icon(Icons.add),
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetFeesBloc>(context).add(RefreshFeesEvent());
    }catch(e){
      print(e);
    }
  }
}