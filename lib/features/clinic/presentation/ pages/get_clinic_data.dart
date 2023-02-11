import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../../../../injection_container.dart' as di;
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/actions_clinic_bloc.dart';
import '../bloc/actions_clinic_event.dart';
import '../bloc/actions_clinic_state.dart';
import '../widgets/clinic_list_widget.dart';

import 'package:geolocator/geolocator.dart';

import 'Add_New_Clinic_data.dart';

class GetClinicDataPage extends StatefulWidget {
  final bool showAddAndEdit;

  const GetClinicDataPage({Key? key, required this.showAddAndEdit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetClinicDataPage();
  }
}

class _GetClinicDataPage extends State<GetClinicDataPage> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    }
  }

  _location() async {

    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .catchError((onError) {
      print(onError);
    });

    // openMap(position.latitude, position.longitude);
  }

  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clinic Data')),
      body: _buildBody(),
      floatingActionButton: widget.showAddAndEdit == true
          ? _buildFloatingBtn(context)
          : Container(),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: BlocProvider<AddUpdateGetClinicBloc>(
            create: (context) =>
                di.sl<AddUpdateGetClinicBloc>()..add(GetClinicEvent()),
            child: BlocBuilder<AddUpdateGetClinicBloc, AddUpdateGetClinicState>(
              builder: (context, state) {
                if (state is LoadingClinicState) {
                  return LoadingWidget();
                } else if (state is LoadedClinicState) {
                  return RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: ClinicListWidget(
                          clinic: state.clinic,
                          showAddAndEdit: widget.showAddAndEdit));
                } else if (state is ErrorClinicState) {
                  return MessageDisplayWidget(message: state.message);
                }
                return LoadingWidget();
              },
            )));
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        _location();
        Navigator.push(context,
            MaterialPageRoute(builder: (_)=> AddNewClinicDataPage(showAddAndEdit:widget.showAddAndEdit)));
      },
      child: Icon(Icons.add),
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetClinicBloc>(context)..add(GetClinicEvent());
    } catch (e) {
      print(e);
    }
  }
}
