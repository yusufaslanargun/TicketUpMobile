import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON parsing
import 'pages.dart';
import "qr_scanner.dart";

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({super.key});

  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  bool isChecked = false; // Checkbox state
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
    }

    final url = Uri.parse(
        'http://46.101.166.170:8080/ticketup/security-officers/login?email=$email&password=$password');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result == true) {
          // show login success message as a dialog then navigate to QRCodeScannerPage

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Giriş Başarılı"),
              content: const Text("QR taramaya başlayabilirsiniz."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QRCodeScannerPage()),
                    );
                  },
                  child: const Text("Tamam"),
                )
              ],
            ),
          );
        } else {
          print("Login failed");
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Giriş Başarısız"),
              content: const Text("Kullanıcı adı veya şifre hatalı."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Tamam"),
                )
              ],
            ),
          );
        }
      } else {
        print("Error: ${response.statusCode}");
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Error"),
            content: Text("Server error: ${response.statusCode}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
    } catch (e) {
      print("Exception: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: const Text("bir hata oluştu."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
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
              padding:
                  EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 112),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "TicketUp'a Giriş Yap\n(Sadece Güvenlik Girişine açıktır.)",
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
                        title: "KULLANICI ADI YA DA E-POSTA",
                        hintText: ""),
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
                        title: "ŞİFRE",
                        hintText: ""),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 32, top: 16, bottom: 16),
              child: GradientButton(
                  text: "Giriş Yap",
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
