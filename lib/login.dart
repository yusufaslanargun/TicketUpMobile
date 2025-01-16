import 'package:flutter/material.dart';
import 'pages.dart';

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({super.key});

  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  bool isChecked = false; // Checkbox'ın durumu
  TextEditingController usernameController =
      TextEditingController(); // İsim input controller
  TextEditingController passwordController =
      TextEditingController(); // Soyisim input controller
  // Tercihleri temizleme fonksiyonu
  void clearPreferences() {
    setState(() {
      usernameController.clear();
      passwordController.clear();
      isChecked = false; // Checkbox'ı inaktif yap
    });
  }

  // Gönder butonunun fonksiyonu
  void sendForm() {
    print("Gönderildi");
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
                child: Text("TicketUp'a Giriş Yap",
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
            // Butonlar
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 32, top: 16, bottom: 16),
              child: GradientButton(
                  text: "Giriş Yap",
                  onClick: () {
                    print("giriş yap");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
