import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';
import 'package:clinic/features/visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormVisitorWidget extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _titleController,
              validator: (val) => val!.isEmpty ? 'must add the name of visitor' : null,
              decoration: InputDecoration(hintText: 'Name'),
              minLines: 2,
              maxLines: 2,
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _bodyController,
              validator: (val) => val!.isEmpty ? 'must add the reason of visitor' : null,
              decoration: InputDecoration(hintText: 'reason'),
              minLines: 2,
              maxLines: 2,
            ),
          ),
          ElevatedButton.icon(
              onPressed:()=> validateFormThenUpdateOrAddPost(context),
              icon: Icon(Icons.add),
              label: Text('Add Visitor')
          )
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {
        final now = DateTime.now();
        final visitor = Visitor(
            id: 0,
            addedBy: 5,
            reasonOfVisitor: _bodyController.text.toString(),
            addedByName: '',
            approved: false,
            name: _titleController.text.toString(),
            time: '${now.year}-${now.month}-${now.day}');
        BlocProvider.of<AddUpdateVisitorBloc>(context)
            .add(AddVisitorEvent(visitor: visitor));
      }
      catch (e){
        print(e);
      }


    }
  }
}