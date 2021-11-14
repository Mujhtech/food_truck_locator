import 'package:flutter/material.dart';

class MeetingModel {
  MeetingModel(
      this.appointmentId,
      this.eventName,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.information,
      this.address,
      this.number,
      this.fullname,
      this.phoneNumber,
      this.email);

  String eventName;
  String appointmentId;
  DateTime from;

  DateTime to;

  Color background;
  bool isAllDay;

  String information;
  String phoneNumber;
  String fullname;
  String email;
  int number;
  String address;
}
