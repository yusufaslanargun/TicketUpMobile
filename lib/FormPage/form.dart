import 'package:flutter/material.dart';
import '../pages.dart';

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
  void sendForm() {
    print("Gönderildi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/ticketup_icon_full.png',
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
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
                        hintText: ""),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputBox(
                        controller: surnameController,
                        title: "SOYİSİM *",
                        hintText: ""),
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
                        hintText: ""),
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
                        hintText: ""),
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
                        hintText: ""),
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
          ],
        ),
      ),
    );
  }
}