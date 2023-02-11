import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../ domain/entities/Clinic.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/actions_clinic_bloc.dart';
import '../bloc/actions_clinic_event.dart';

class GetLocation extends StatefulWidget {
  final Clinic clinicData;
  final bool isItUpdate;

  GetLocation({Key? key, required this.clinicData, required this.isItUpdate}) : super(key: key);
  @override
  _MapsSampleState createState() => _MapsSampleState();
}

class _MapsSampleState extends State<GetLocation> {
  Set<Marker> _createMarker = <Marker>{};

  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();
@override
  void initState() {
    super.initState();

    if (widget.clinicData.latitude != null && widget.clinicData.longitude !=null && widget.clinicData.latitude != '' && widget.clinicData.longitude !='') {
      print('widget.clinicData.latitude: ${widget.clinicData.latitude}');
      print('widget.clinicData.longitude: ${widget.clinicData.longitude}');
      _createMarker.add(Marker(
          markerId: MarkerId(''),
          position: LatLng(
            double.parse(widget.clinicData.latitude!),
            double.parse(widget.clinicData.longitude!),
          )));

    }
  }
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Future _location() async {
    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .catchError((onError) {
      print(onError);
    });
    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps in Flutter'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
              future: _location(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  LatLng latLng = snapshot.data as LatLng;
                  return GoogleMap(
                    markers: _createMarker,
                    mapType: _defaultMapType,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latLng.latitude, latLng.longitude),
                      zoom: 11.0,
                    ),
                    onTap: (position) {
                      print('position.latitude: ${position.latitude}');
                      print('position.longitude: ${position.longitude}');
                      setState(() {
                        _createMarker.clear();
                        _createMarker.add(Marker(
                          markerId: MarkerId(''),
                          position:
                              LatLng(position.latitude, position.longitude),
                        ));
                      });
                    },
                  );
                } else {
                  return LoadingWidget();
                }
              }),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "btn1",
                    child: Icon(Icons.layers),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _changeMapType();
                    }),
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            left: 10,
            child: FloatingActionButton(
                heroTag: "btn2",
                child: Icon(Icons.done),
                onPressed: () {
                  validateFormAddClinic();
                }),
          )
        ],
      ),
    );
  }
  void validateFormAddClinic() {
    if (_createMarker.length>=1){

      try {
        final clinic = Clinic(
            id: widget.clinicData.id,
            addrees: widget.clinicData.addrees,
            note: widget.clinicData.note,
            fromTime: widget.clinicData.fromTime,
            toTime: widget.clinicData.toTime,
            timeOfVacation: widget.clinicData.timeOfVacation,
            latitude: _createMarker.first.position.latitude.toString(),
            longitude: _createMarker.first.position.longitude.toString()
        );
        if (widget.isItUpdate == false) {
          BlocProvider.of<AddUpdateGetClinicBloc>(context)
              .add(AddClinicEvent(clinic: clinic));
        }else{
          print(_createMarker);
          print(clinic.latitude);
          print(clinic.longitude);
          BlocProvider.of<AddUpdateGetClinicBloc>(context)
              .add(UpdateClinicEvent(clinic: clinic));
        }
      }
      catch (e){
        print(e);
      }
    }else{
      BlocProvider.of<AddUpdateGetClinicBloc>(context)
          .add(AddClinicEvent(clinic: widget.clinicData));
      if (widget.isItUpdate == false) {
        BlocProvider.of<AddUpdateGetClinicBloc>(context)
            .add(AddClinicEvent(clinic: widget.clinicData));
      }else{
        BlocProvider.of<AddUpdateGetClinicBloc>(context)
            .add(UpdateClinicEvent(clinic: widget.clinicData));
      }
    }
    Navigator.pop(context);

    }

  }

