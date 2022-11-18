import 'package:clinic/features/visitor/presentation/bloc/visitor/visitor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart' as di;
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/Visitor_list_widget.dart';
import '../../../../core/widgets/message_display_widget.dart';
import 'add_visitor.dart';
class GetAllVisitors extends StatelessWidget{
  final String? typeOfLogin;

  const GetAllVisitors({Key? key, this.typeOfLogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(title: Text('Visitors'));

  Widget _buildBody(){
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: BlocProvider<VisitorBloc>(
          create: (context) => di.sl<VisitorBloc>()..add(GetAllVisitorsEvent()),
          child:BlocBuilder<VisitorBloc, VisitorState>(
            builder: (context, state) {
              if (state is LoadingVisitorsState){
                return LoadingWidget();
              }
              else if (state is LoadedVisitorsState) {
                return RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: VisitorListWidget(visitor: state.visitors, typeOfLogin: typeOfLogin));
              }
              else if (state is ErrorVisitorssState) {
                return MessageDisplayWidget(message: state.message, typeOfLogin: typeOfLogin);
              }
              return LoadingWidget();
            },
          )
        ),
    );
  }



  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> VisitorAddPage()));
      },
      child: Icon(Icons.add),
    );
  }
  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<VisitorBloc>(context).add(RefreshVisitorsEvent());
    }
    catch(e){
      print(e);
    }
  }
}