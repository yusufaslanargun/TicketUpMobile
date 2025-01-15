import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import qr_flutter package
import 'bottom_bar.dart';

class TicketInfoPage extends StatelessWidget {
  final Map<String, String> ticket = {
    'title': 'Concert',
    'date': '2022-12-31',
    'location': 'New York',
    'participantId': '123456',
  };

  final Map<String, String> event = {
    'name': 'New Year Celebration',
    'startDate': '2022-12-31',
    'startTime': '20:00',
    'location': 'Times Square, New York',
  };

  final Map<String, String> participant = {
    'name': 'John',
    'surname': 'Doe',
    'title': 'Software Engineer',
    'city': 'New York',
  };

  TicketInfoPage({super.key});

  void navigateToForm() {
    print("Navigating to form page");
  }

  void navigateToHistory() {
    print("Navigating to history page");
  }

  void scanCode() {
    print("Scanning QR code");
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
              'assets/icons/ticketup_logo_wh.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text('Bilet', style: TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(  // Wrap the entire body with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF444444),
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date: ${ticket['date']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Location: ${ticket['location']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: const Color(0xFF444444),
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    QrImageView(
                      data: ticket['participantId'] ??
                          "No participant ID", // Use the participant ID or other data
                      version: QrVersions
                          .auto, // Automatically determine the QR code version
                      size: 150.0, // Set the size of the QR code
                      backgroundColor:
                          Colors.white, // Background color of the QR code
                    ),
                    SizedBox(height: 16),
                    const Text(
                      'Etkinlik Bilgileri',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event['name'] ?? "Bilet Bilgileri Yükleniyor...",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn("TARİH",
                            event['startDate'] ?? "Tarih yükleniyor..."),
                        _buildInfoColumn(
                            "SAAT", event['startTime'] ?? "Saat Yükleniyor..."),
                        _buildInfoColumn("KONUM",
                            event['location'] ?? "Konum Yükleniyor..."),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Katılımcı Bilgileri
                    const Text(
                      'Katılımcı Bilgileri',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn(
                          "Ad-Soyad",
                          "${participant['name'] ?? "Yükleniyor..."} ${participant['surname'] ?? "Yükleniyor..."}",
                        ),
                        _buildInfoColumn(
                            "Ünvan", participant['title'] ?? "Yükleniyor..."),
                        _buildInfoColumn("Katılınılan İl",
                            participant['city'] ?? "Yükleniyor..."),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Katılımcı ID
                    const Text(
                      'KATILIMCI ID',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ticket['participantId'] ?? "Yükleniyor...",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bilmeniz Gerekenler
                    const Text(
                      'Bilmeniz Gerekenler',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Etkinlik girişinde karekodunuzu gösterek giriş yapabilirsiniz. '
                      'Etkinlik biletiniz ayrıca mail adresinize ve SMS olarak gönderilecektir. '
                      'Organizatör ile iletişim için: info@upista.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

Widget _buildInfoColumn(String title, String value) {
  return Expanded(  // Wrap each column in Expanded to make sure they don't overflow
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
