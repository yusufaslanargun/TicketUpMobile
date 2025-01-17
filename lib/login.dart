import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/components/gradient_button.dart';
import 'package:project/components/input_box.dart';
import 'dart:convert'; // For JSON parsing
import "qr_scanner.dart";
import 'package:provider/provider.dart'; // Provider desteği
import 'state/event_state.dart'; // EventState import edildi

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({super.key});

  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  bool isChecked = false; // Checkbox state
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Clear preferences function
  void clearPreferences() {
    setState(() {
      usernameController.clear();
      passwordController.clear();
      isChecked = false;
    });
  }

  // Login function to call API
  Future<void> login() async {
    final email = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Please enter both email and password."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
      return; // Eğer alanlar boşsa, işlemi sonlandır
    }

    final url = Uri.parse(
        'http://46.101.166.170:8080/ticketup/security-officers/login?email=$email&password=$password');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        if (result['success'] == true) {
          // Event ID'yi al ve kaydet
          final eventId = result['eventId'];
          if (eventId != null) {
            Provider.of<EventState>(context, listen: false).setEventId(eventId);
          }

          // QR kod tarama sayfasına yönlendir
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const QRCodeScannerPage()),
          );
        } else {
          _showErrorDialog("Login Failed", "Invalid username or password.");
        }
      } else {
        _showErrorDialog("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      _showErrorDialog("Error", "An unexpected error occurred: $e");
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/ticketup_logo_wh.png',
              height: 40,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 16, bottom: 112),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                    "Log in to TicketUp\n(Access restricted to security personnel only.)",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InputBox(
                      controller: usernameController,
                      title: "Username or Email",
                      hintText: "Enter your email",
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InputBox(
                        controller: passwordController,
                        title: "Password",
                        hintText: "Enter your password",
                        obscureText: true),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 32, top: 16, bottom: 16),
              child: GradientButton(
                  text: "Login",
                  onClick: () {
                    login();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
