import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import "past_scan_ticket.dart";
import 'pages.dart';
import 'package:provider/provider.dart';
import 'state/event_state.dart'; // EventState dosyasının yolu
import 'qr_scanner.dart';
import "login.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const NewLoginPage(), // Changed from HomePage to LoginPage
    );
  }
}
