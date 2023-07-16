// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `or continue with`
  String get OrContinueWith {
    return Intl.message(
      'or continue with',
      name: 'OrContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account`
  String get DonnotHaveAccount {
    return Intl.message(
      'Don\'t have account',
      name: 'DonnotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get CreateAccount {
    return Intl.message(
      'Create Account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login to Your Account`
  String get LoginToYourAccount {
    return Intl.message(
      'Login to Your Account',
      name: 'LoginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get RememberMe {
    return Intl.message(
      'Remember me',
      name: 'RememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Update Clinic Data`
  String get UpdateClinicData {
    return Intl.message(
      'Update Clinic Data',
      name: 'UpdateClinicData',
      desc: '',
      args: [],
    );
  }

  /// `Add Clinic Data`
  String get AddClinicData {
    return Intl.message(
      'Add Clinic Data',
      name: 'AddClinicData',
      desc: '',
      args: [],
    );
  }

  /// `Maps in Flutter`
  String get MapsInFlutter {
    return Intl.message(
      'Maps in Flutter',
      name: 'MapsInFlutter',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get From {
    return Intl.message(
      'From',
      name: 'From',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get To {
    return Intl.message(
      'To',
      name: 'To',
      desc: '',
      args: [],
    );
  }

  /// `Time of vacation`
  String get TimeOfVacation {
    return Intl.message(
      'Time of vacation',
      name: 'TimeOfVacation',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get Location {
    return Intl.message(
      'Location',
      name: 'Location',
      desc: '',
      args: [],
    );
  }

  /// `Add Location`
  String get AddLocation {
    return Intl.message(
      'Add Location',
      name: 'AddLocation',
      desc: '',
      args: [],
    );
  }

  /// `Add New Clinic`
  String get AddNewClinic {
    return Intl.message(
      'Add New Clinic',
      name: 'AddNewClinic',
      desc: '',
      args: [],
    );
  }

  /// `Add Doctor Data`
  String get AddDoctorData {
    return Intl.message(
      'Add Doctor Data',
      name: 'AddDoctorData',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Data`
  String get DoctorData {
    return Intl.message(
      'Doctor Data',
      name: 'DoctorData',
      desc: '',
      args: [],
    );
  }

  /// `Add New Doctor`
  String get AddNewDoctor {
    return Intl.message(
      'Add New Doctor',
      name: 'AddNewDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Fees of month`
  String get FeesOfMonth {
    return Intl.message(
      'Fees of month',
      name: 'FeesOfMonth',
      desc: '',
      args: [],
    );
  }

  /// `Fees of day`
  String get FeesOfDay {
    return Intl.message(
      'Fees of day',
      name: 'FeesOfDay',
      desc: '',
      args: [],
    );
  }

  /// `The Doctors`
  String get TheDoctors {
    return Intl.message(
      'The Doctors',
      name: 'TheDoctors',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Add Visitor`
  String get AddVisitor {
    return Intl.message(
      'Add Visitor',
      name: 'AddVisitor',
      desc: '',
      args: [],
    );
  }

  /// `Visitors`
  String get Visitors {
    return Intl.message(
      'Visitors',
      name: 'Visitors',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get Reason {
    return Intl.message(
      'Reason',
      name: 'Reason',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get AlreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'AlreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register to Your Account`
  String get RegisterToYourAccount {
    return Intl.message(
      'Register to Your Account',
      name: 'RegisterToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get UserName {
    return Intl.message(
      'User Name',
      name: 'UserName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get SignUp {
    return Intl.message(
      'Sign up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Update user`
  String get UpdateUser {
    return Intl.message(
      'Update user',
      name: 'UpdateUser',
      desc: '',
      args: [],
    );
  }

  /// `must add the password`
  String get MustAddThePassword {
    return Intl.message(
      'must add the password',
      name: 'MustAddThePassword',
      desc: '',
      args: [],
    );
  }

  /// `Add medical re-examination`
  String get AddMedicalReExamination {
    return Intl.message(
      'Add medical re-examination',
      name: 'AddMedicalReExamination',
      desc: '',
      args: [],
    );
  }

  /// `Add sick`
  String get AddSick {
    return Intl.message(
      'Add sick',
      name: 'AddSick',
      desc: '',
      args: [],
    );
  }

  /// `must add the name of sick`
  String get MustAddTheNameOfSick {
    return Intl.message(
      'must add the name of sick',
      name: 'MustAddTheNameOfSick',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the doctor's examination`
  String get WaitingForTheDoctorsExamination {
    return Intl.message(
      'Waiting for the doctor\'s examination',
      name: 'WaitingForTheDoctorsExamination',
      desc: '',
      args: [],
    );
  }

  /// `Sick`
  String get Sick {
    return Intl.message(
      'Sick',
      name: 'Sick',
      desc: '',
      args: [],
    );
  }

  /// `must add the phone number`
  String get MustAddThePhoneNumber {
    return Intl.message(
      'must add the phone number',
      name: 'MustAddThePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `your number not right`
  String get YourNumberNotRight {
    return Intl.message(
      'your number not right',
      name: 'YourNumberNotRight',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of Statement`
  String get DateOfStatement {
    return Intl.message(
      'Date of Statement',
      name: 'DateOfStatement',
      desc: '',
      args: [],
    );
  }

  /// `Choose the date`
  String get ChooseTheDate {
    return Intl.message(
      'Choose the date',
      name: 'ChooseTheDate',
      desc: '',
      args: [],
    );
  }

  /// `must choose date`
  String get MustChooseDate {
    return Intl.message(
      'must choose date',
      name: 'MustChooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Type of Statement`
  String get TypeOfStatement {
    return Intl.message(
      'Type of Statement',
      name: 'TypeOfStatement',
      desc: '',
      args: [],
    );
  }

  /// `Consultation`
  String get Consultation {
    return Intl.message(
      'Consultation',
      name: 'Consultation',
      desc: '',
      args: [],
    );
  }

  /// `Statement`
  String get Statement {
    return Intl.message(
      'Statement',
      name: 'Statement',
      desc: '',
      args: [],
    );
  }

  /// `must add the name of visitor`
  String get MustAddTheNameOfVisitor {
    return Intl.message(
      'must add the name of visitor',
      name: 'MustAddTheNameOfVisitor',
      desc: '',
      args: [],
    );
  }

  /// `must add the reason of visitor`
  String get MustAddTheReasonOfVisitor {
    return Intl.message(
      'must add the reason of visitor',
      name: 'MustAddTheReasonOfVisitor',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get SignIn {
    return Intl.message(
      'Sign in',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  /// `must add the name of user`
  String get MustAddTheNameOfUser {
    return Intl.message(
      'must add the name of user',
      name: 'MustAddTheNameOfUser',
      desc: '',
      args: [],
    );
  }

  /// `must add the email of user`
  String get MustAddTheEmailOfUser {
    return Intl.message(
      'must add the email of user',
      name: 'MustAddTheEmailOfUser',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get Report {
    return Intl.message(
      'Report',
      name: 'Report',
      desc: '',
      args: [],
    );
  }

  /// `Add Nurse Data`
  String get AddNurseData {
    return Intl.message(
      'Add Nurse Data',
      name: 'AddNurseData',
      desc: '',
      args: [],
    );
  }

  /// `Nurse Data`
  String get NurseData {
    return Intl.message(
      'Nurse Data',
      name: 'NurseData',
      desc: '',
      args: [],
    );
  }

  /// `must add the email of Nurse`
  String get MustAddTheEmailOfNurse {
    return Intl.message(
      'must add the email of Nurse',
      name: 'MustAddTheEmailOfNurse',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Nurse Email' key

  /// `must add the name of Nurse`
  String get MustAddTheNameOfNurse {
    return Intl.message(
      'must add the name of Nurse',
      name: 'MustAddTheNameOfNurse',
      desc: '',
      args: [],
    );
  }

  /// `First Phone Number`
  String get FirstPhoneNumber {
    return Intl.message(
      'First Phone Number',
      name: 'FirstPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Second Phone Number`
  String get SecondPhoneNumber {
    return Intl.message(
      'Second Phone Number',
      name: 'SecondPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get Description {
    return Intl.message(
      'Description',
      name: 'Description',
      desc: '',
      args: [],
    );
  }

  /// `must add the description`
  String get MustAddTheDescription {
    return Intl.message(
      'must add the description',
      name: 'MustAddTheDescription',
      desc: '',
      args: [],
    );
  }

  /// `your password must be longer than 12`
  String get YourPasswordMustBeLongerThan12 {
    return Intl.message(
      'your password must be longer than 12',
      name: 'YourPasswordMustBeLongerThan12',
      desc: '',
      args: [],
    );
  }

  /// `Add New Nurse`
  String get AddNewNurse {
    return Intl.message(
      'Add New Nurse',
      name: 'AddNewNurse',
      desc: '',
      args: [],
    );
  }

  /// `Add The Fees of Clinic`
  String get AddTheFeesOfClinic {
    return Intl.message(
      'Add The Fees of Clinic',
      name: 'AddTheFeesOfClinic',
      desc: '',
      args: [],
    );
  }

  /// `Update The Fees of Clinic`
  String get UpdateTheFeesOfClinic {
    return Intl.message(
      'Update The Fees of Clinic',
      name: 'UpdateTheFeesOfClinic',
      desc: '',
      args: [],
    );
  }

  /// `must choose day`
  String get MustChooseDay {
    return Intl.message(
      'must choose day',
      name: 'MustChooseDay',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done {
    return Intl.message(
      'Done',
      name: 'Done',
      desc: '',
      args: [],
    );
  }

  /// `Fees`
  String get Fees {
    return Intl.message(
      'Fees',
      name: 'Fees',
      desc: '',
      args: [],
    );
  }

  /// `must add the type of fees`
  String get MustAddTheTypeOfFees {
    return Intl.message(
      'must add the type of fees',
      name: 'MustAddTheTypeOfFees',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get Type {
    return Intl.message(
      'Type',
      name: 'Type',
      desc: '',
      args: [],
    );
  }

  /// `must add the price of fees`
  String get MustAddThePriceOfFees {
    return Intl.message(
      'must add the price of fees',
      name: 'MustAddThePriceOfFees',
      desc: '',
      args: [],
    );
  }

  /// `must be numbers`
  String get MustBeNumbers {
    return Intl.message(
      'must be numbers',
      name: 'MustBeNumbers',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get price {
    return Intl.message(
      'price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date {
    return Intl.message(
      'Date',
      name: 'Date',
      desc: '',
      args: [],
    );
  }

  /// `must choose date of fees`
  String get MustChooseDateOfFees {
    return Intl.message(
      'must choose date of fees',
      name: 'MustChooseDateOfFees',
      desc: '',
      args: [],
    );
  }

  /// `Add Fees`
  String get AddFees {
    return Intl.message(
      'Add Fees',
      name: 'AddFees',
      desc: '',
      args: [],
    );
  }

  /// `Update Fees`
  String get UpdateFees {
    return Intl.message(
      'Update Fees',
      name: 'UpdateFees',
      desc: '',
      args: [],
    );
  }

  /// `must add the email of doctor`
  String get MustAddTheEmailOfDoctor {
    return Intl.message(
      'must add the email of doctor',
      name: 'MustAddTheEmailOfDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get Doctor {
    return Intl.message(
      'Doctor',
      name: 'Doctor',
      desc: '',
      args: [],
    );
  }

  /// `must add the name of doctor`
  String get MustAddTheNameOfDoctor {
    return Intl.message(
      'must add the name of doctor',
      name: 'MustAddTheNameOfDoctor',
      desc: '',
      args: [],
    );
  }

  /// `must add the address of clinic`
  String get MustAddTheAddressOfClinic {
    return Intl.message(
      'must add the address of clinic',
      name: 'MustAddTheAddressOfClinic',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get Note {
    return Intl.message(
      'Note',
      name: 'Note',
      desc: '',
      args: [],
    );
  }

  /// `must add the days of vacations`
  String get MustAddTheDaysOfVacations {
    return Intl.message(
      'must add the days of vacations',
      name: 'MustAddTheDaysOfVacations',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get StartTime {
    return Intl.message(
      'Start time',
      name: 'StartTime',
      desc: '',
      args: [],
    );
  }

  /// `must add the Start time of clinic`
  String get MustAddTheStartTimeOfClinic {
    return Intl.message(
      'must add the Start time of clinic',
      name: 'MustAddTheStartTimeOfClinic',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get EndTime {
    return Intl.message(
      'End time',
      name: 'EndTime',
      desc: '',
      args: [],
    );
  }

  /// `Clinic Data`
  String get ClinicData {
    return Intl.message(
      'Clinic Data',
      name: 'ClinicData',
      desc: '',
      args: [],
    );
  }

  /// `Must Choose Time`
  String get MustChooseTime {
    return Intl.message(
      'Must Choose Time',
      name: 'MustChooseTime',
      desc: '',
      args: [],
    );
  }

  /// `must add the end time of clinic`
  String get MustAddTheEndTimeOfClinic {
    return Intl.message(
      'must add the end time of clinic',
      name: 'MustAddTheEndTimeOfClinic',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Visitor`
  String get Visitor {
    return Intl.message(
      'Visitor',
      name: 'Visitor',
      desc: '',
      args: [],
    );
  }

  /// `Clinic`
  String get Clinic {
    return Intl.message(
      'Clinic',
      name: 'Clinic',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
