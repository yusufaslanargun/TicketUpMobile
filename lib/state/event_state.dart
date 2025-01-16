import 'package:flutter/material.dart';

class EventState with ChangeNotifier {
  String _eventId = "fc29e7b2-a366-4fcf-9df2-6a8bee6db1c3"; // Etkinlik ID'sini saklayan değişken

  // Etkinlik ID'sini okumak için getter
  String get eventId => _eventId;

  // Etkinlik ID'sini değiştirmek için setter
  void setEventId(String id) {
    _eventId = id;
    notifyListeners(); // Değişikliği dinleyen widgetlara haber verir
  }
}
