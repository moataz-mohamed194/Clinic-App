import 'package:clinic/features/doctor/%20domain/entities/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DoctorListWidget extends StatelessWidget{
  final List<Doctor> doctor;

  const DoctorListWidget({Key? key, required this.doctor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: doctor.length,

        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),

              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                          // height: 150.0,
                          // width: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${doctor[index].name.toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                          Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                  '${doctor[index].phoneNumber.toString()}',
                                  textAlign:TextAlign.center
                              ),
                              SizedBox(width: 20,),
                              Container(height: 20,width: 1,color: Colors.grey.shade300,),

                              SizedBox(width: 20,),
                              Expanded(
                                child: Text(
                                    '${doctor[index].email.toString()}',
                                    textAlign:TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${doctor[index].description}',
                              softWrap: true
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

        },
        // separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
}