import 'package:flutter/material.dart';
import 'pages.dart';
import 'package:provider/provider.dart';
import 'state/event_state.dart';
import 'dart:convert'; // JSON işlemleri için
import 'package:http/http.dart' as http; // HTTP istekleri için
import "qr_scanner.dart";

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool isChecked = false; // Checkbox'ın durumu
  TextEditingController nameController =
      TextEditingController(); // İsim input controller
  TextEditingController surnameController =
      TextEditingController(); // Soyisim input controller
  TextEditingController emailController =
      TextEditingController(); // E-posta input controller
  TextEditingController phoneController =
      TextEditingController(); // Telefon input controller
  TextEditingController additionalController =
      TextEditingController(); // Eklemek istedikleriniz input controller

  // Tercihleri temizleme fonksiyonu
  void clearPreferences() {
    setState(() {
      nameController.clear();
      surnameController.clear();
      emailController.clear();
      phoneController.clear();
      additionalController.clear();
      isChecked = false; // Checkbox'ı inaktif yap
    });
  }

  // Gönder butonunun fonksiyonu
  Future<void> sendForm() async {
    final eventState = Provider.of<EventState>(context, listen: false);
    String eventId = eventState.eventId;

    if (eventId.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Hata"),
          content: const Text("Event ID bulunamadı. Lütfen tekrar deneyin."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
      return;
    }

    final requestBody = {
      "eventId": eventId,
      "name": nameController.text,
      "surname": surnameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "description": additionalController.text,
      "isFirstTime": isChecked,
    };

    try {
      final participantResponse = await http.post(
        Uri.parse("http://46.101.166.170:8080/ticketup/participants/create"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody),
      );

      if (participantResponse.statusCode == 200) {
        final participantId = participantResponse.body;

        final ticketRequest = {
          "eventId": eventId,
          "participantId": participantId.replaceAll(
              '"', ''), // Fazladan çift tırnakları kaldırıyoruz
        };

        final ticketResponse = await http.post(
          Uri.parse("http://46.101.166.170:8080/ticketup/tickets/create"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(ticketRequest),
        );

        if (ticketResponse.statusCode == 200) {
          final ticketId = ticketResponse.body;

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Başarılı"),
              content: Text("Bilet oluşturuldu! Bilet ID: $ticketId"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Tamam"),
                ),
              ],
            ),
          );
        } else {
          throw Exception("Bilet oluşturulamadı: ${ticketResponse.body}");
        }
      } else {
        throw Exception(
            "Katılımcı oluşturulamadı: ${participantResponse.body}");
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Hata"),
          content: Text("Bir hata oluştu: $error"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    }
  }

  void navigateToForm() {
    // Navigate to the form page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FormPage()),
    );
  }

  void navigateToHistory() {
    print("Navigating to history page");
  }

  void scanCode() {
    // Navigate to the QR code scanner page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const QRCodeScannerPage()),
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
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Icon(Icons.person_pin_rounded,
                color: const Color(0xFFF2F2F2), size: 48),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InputBox(
                      controller: nameController,
                      title: "İSİM *",
                      hintText: "",
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputBox(
                        controller: surnameController,
                        title: "SOYİSİM *",
                        hintText: "",
                        obscureText: false),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InputBox(
                        controller: emailController,
                        title: "E-POSTA *",
                        hintText: "",
                        obscureText: false),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InputBox(
                      controller: phoneController,
                      title: "TELEFON NO *",
                      hintText: "",
                      obscureText: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InputBox(
                      controller: additionalController,
                      title: "EKLEMEK İSTEDİKLERİNİZ *",
                      hintText: "",
                      obscureText: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Checkbox(
                    value: isChecked, // Checkbox'ın durumu
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false; // Durumu güncelle
                      });
                    },
                    activeColor: Colors.white, // Checkbox'ın renk düzeni
                  ),
                  Expanded(
                    child: Text(
                      "6698 Sayılı KVKK uyarınca, gerçekleşecek olan etkinlikte bilgilerimin paylaşılmasını kabul ediyorum.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12, // Küçük font boyutu
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Butonlar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tercihleri Temizle Butonu
                  ElevatedButton(
                    onPressed: clearPreferences,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Buton rengi
                    ),
                    child: const Text("Tercihleri Temizle"),
                  ),
                  // Gönder Butonu
                  ElevatedButton(
                    onPressed: sendForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Buton rengi
                    ),
                    child: const Text("Gönder"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        onHistoryTap: navigateToHistory,
        onFormTap: navigateToForm,
        onScanTap: scanCode,
      ),
      floatingActionButton: SizedBox(
        height: 80, // Larger height
        width: 80, // Larger width
        child: FloatingActionButton(
          onPressed: scanCode,
          backgroundColor: const Color(0xFFD6125E),
          child: const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: 32, // Larger icon size
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
