import 'package:flutter/material.dart';

class EventState with ChangeNotifier {
  String _eventId = ""; // Etkinlik ID'sini saklayan değişken

  // Etkinlik ID'sini okumak için getter
  String get eventId => _eventId;

  // Etkinlik ID'sini değiştirmek için setter
  void setEventId(String id) {
    _eventId = id;
    notifyListeners(); // Değişikliği dinleyen widgetlara haber verir
  }
}
