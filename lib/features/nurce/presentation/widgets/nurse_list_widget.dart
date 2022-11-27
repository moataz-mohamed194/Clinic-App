import 'package:flutter/material.dart';

import '../../ domain/entities/Nurse.dart';


class NurseListWidget extends StatelessWidget{
  final List<Nurse> nurse;

  const NurseListWidget({Key? key, required this.nurse}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: nurse.length,

        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child:Text(
                      '${index+1}',
                      textAlign: TextAlign.center,
                  ),
                    flex: 1
                ),
                Expanded(
                    child:Container(
                      child: Column(
                        children: [
                          Text('${nurse[index].userName.toString()}'),
                          Column(
                            children: [
                              Text(
                                      'Email: ${nurse[index].email.toString()}',
                                      textAlign:TextAlign.center
                                    ),
                              Text(
                                      'First Phone Number: ${nurse[index].firstPhoneNumber.toString()}',
                                      textAlign:TextAlign.center
                                  ),
                              Text(
                                      'Second Phone Number: ${nurse[index].secondPhoneNumber.toString()}',
                                      textAlign:TextAlign.center
                                  )
                            ],
                          ),
                          Text(
                            'Description: ${nurse[index].description}',
                              softWrap: true
                          ),
                        ],
                      ),
                    ),
                    flex:5
                ),
              ],
            ),
          );

        },
        separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
}