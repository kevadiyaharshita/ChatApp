import 'package:flutter/material.dart';

class ContactModal {
  String name, phone, image, date, time, chat;
  // DateTime date;
  // TimeOfDay time;

  ContactModal(
      {required this.name,
      required this.phone,
      required this.date,
      required this.time,
      required this.chat,
      this.image = ""});
}
