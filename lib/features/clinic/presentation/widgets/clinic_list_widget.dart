import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ pages/Add_New_Clinic_data.dart';
import '../../ domain/entities/Clinic.dart';
import '../../../../core/widgets/AdWidget.dart';
import '../../../../generated/l10n.dart';

class ClinicListWidget extends StatelessWidget {
  final List<Clinic> clinic;
  final bool showAddAndEdit;
  const ClinicListWidget(
      {Key? key, required this.clinic, required this.showAddAndEdit})
      : super(key: key);

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    Uri _url = Uri.parse(googleUrl);
    // launchUrl(Uri.parse(googleUrl));
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: clinic.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            AdWidgets(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                      ),
                      flex: 1),
                  Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                                '${S.of(context).Address}: ${clinic[index].addrees.toString()}'),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        '${S.of(context).From}: ${clinic[index].fromTime.toString()}',
                                        textAlign: TextAlign.center)),
                                Expanded(
                                    child: Text(
                                        '${S.of(context).To}: ${clinic[index].toTime.toString()}',
                                        textAlign: TextAlign.center))
                              ],
                            ),
                            Text(
                                '${S.of(context).TimeOfVacation}: ${clinic[index].timeOfVacation}',
                                softWrap: true),
                            Text(clinic[index].note.toString()),
                          ],
                        ),
                      ),
                      flex: 5),
                  showAddAndEdit == true
                      ? Expanded(
                          child: Container(
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _onUpdate(context, clinic[index]),
                            ),
                          ),
                          flex: 1)
                      : Container()
                ],
              ),
            ),
            clinic[index].latitude != '' && clinic[index].longitude != ''
                ? TextButton(
                    onPressed: () {
                      openMap(double.parse(clinic[index].latitude!),
                          double.parse(clinic[index].longitude!));
                    },
                    child: Text(S.of(context).Location))
                : Container()
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }

  _onUpdate(BuildContext context, clinic) async {
    try {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AddNewClinicDataPage(
              showAddAndEdit: this.showAddAndEdit, clinic: clinic)));
    } catch (e) {
      print(e);
    }
  }
}
