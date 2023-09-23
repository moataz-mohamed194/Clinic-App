class AppUrl {
  static const BASE_URL = 'https://moataz194.pythonanywhere.com';
  static const UrlLogin = BASE_URL + '/users/login/';
  static const UrlGetClinicsData = BASE_URL + "/users/get_clinic_data/";
  static const UrlModelOfClinic = BASE_URL + '/doctor/model_of_clinic/';
  static const UrlModelOfDoctor = BASE_URL + '/doctor/model_of_doctor/';
  static const UrlEditDataClinic = BASE_URL + '/doctor/edit_data_clinic/';
  static const UrlAddFees = BASE_URL + '/doctor/add_fees/';
  static const UrlFeesUpdateDeleteGet =
      BASE_URL + '/doctor/fees_update_delete_get/';
  static const UrlAddNurse = BASE_URL + '/doctor/add_nurse/';
  static const UrlAddAccount = BASE_URL + '/users/add_account/';
  static const UrlAddVisitor = BASE_URL + "/nurse/add_visitor/";
  static const UrlApproveVisitor = BASE_URL + "/doctor/approve_visitor/";
  static const UrlAddBooking = BASE_URL + '/nurse/add_booking/';
  static const UrlAddReportForSick = BASE_URL + '/doctor/add_report_for_sick/';
  static const UrlApproveBookingForSick = BASE_URL + '/nurse/approve_booking/';
  static String UrlUpdateAccount(String id) {
    return BASE_URL + '/users/update_account/' + id + '/';
  }

  static String UrlGetAllBookingRequisted(String id) {
    return BASE_URL + '/users/get_all_booking_requisted/' + '$id';
  }

  static String UrlEnteredSick(String id) {
    return BASE_URL + '/nurse/entered_sick/' + id + '/';
  }

  static String UrlGetFeesOfDay(String day) {
    return BASE_URL + "/doctor/get_fees_of_day/" + '${day}';
  }

  static String UrlGetFeesOfMonth(String month) {
    return BASE_URL + "/doctor/get_fees_of_month/" + month.toString();
  }
  static const socketKey = '9d5683e257f6cb1e972b5de6a3b5e3bf';
  static const socketUrl = 'wss://socketsbay.com/wss/v2/22/$socketKey/';
}
