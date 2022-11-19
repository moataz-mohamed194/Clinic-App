import 'package:clinic/features/doctor/%20domain/entities/Doctor.dart';
import 'package:flutter/material.dart';


class DoctorListWidget extends StatelessWidget{
  final List<Doctor> doctor;

  const DoctorListWidget({Key? key, required this.doctor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: doctor.length,

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
                          Text('${doctor[index].name.toString()}'),
                          Row(
                            children: [
                              Expanded(
                                  child:Text(
                                      '${doctor[index].email.toString()}',
                                      textAlign:TextAlign.center
                                    )
                                  ),
                              Expanded(
                                  child:Text(
                                      '${doctor[index].phoneNumber.toString()}',
                                      textAlign:TextAlign.center
                                  )
                              )
                            ],
                          ),
                          Text(
                            '${doctor[index].description}',
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