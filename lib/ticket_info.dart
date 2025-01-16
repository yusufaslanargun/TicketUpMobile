import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For API calls
import 'dart:convert'; // For JSON decoding
import 'package:qr_flutter/qr_flutter.dart'; // For QR code display
import 'bottom_bar.dart';
import 'qr_scanner.dart';
import 'form.dart';

class TicketInfoPage extends StatefulWidget {
  final String scannedData;

  TicketInfoPage({Key? key, required this.scannedData}) : super(key: key);

  @override
  _TicketInfoPageState createState() => _TicketInfoPageState();
}

class _TicketInfoPageState extends State<TicketInfoPage> {
  Map<String, dynamic>? ticketData; // Data from the API
  bool isLoading = true; // Loading state
  bool hasError = false; // Error state

  @override
  void initState() {
    super.initState();
    fetchTicketData(); // Fetch data on initialization
  }

  /// Fetch ticket data from the API using the scanned ID
  Future<void> fetchTicketData() async {
    final String apiUrl =
        "http://46.101.166.170:8080/ticketup/security-officers/ticket/${widget.scannedData}";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          ticketData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
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
        title: const Text('Bilet Bilgileri',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : hasError
              ? const Center(
                  child: Text(
                    'Bilet Bulunamadı.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Details
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        'Event Details',
                        [
                          _buildInfoRow(
                              'Event Name', ticketData?['eventName'] ?? 'N/A'),
                          _buildInfoRow(
                              'Event Date', ticketData?['eventDate'] ?? 'N/A'),
                          _buildInfoRow(
                              'Event Time', ticketData?['eventTime'] ?? 'N/A'),
                          _buildInfoRow('Location',
                              ticketData?['eventLocation'] ?? 'N/A'),
                        ],
                      ),
                      // Participant Information
                      _buildInfoCard(
                        'Participant Details',
                        [
                          _buildInfoRow(
                              'Name', ticketData?['participantName'] ?? 'N/A'),
                          _buildInfoRow('Surname',
                              ticketData?['participantSurname'] ?? 'N/A'),
                          _buildInfoRow('Phone',
                              ticketData?['participantPhone'] ?? 'N/A'),
                          _buildInfoRow('Email',
                              ticketData?['participantEmail'] ?? 'N/A'),
                        ],
                      ),
                      // QR Code
                      const SizedBox(height: 16),
                      Center(
                        child: QrImageView(
                          data: ticketData?['ticketId'] ?? 'Böyle Bilet Yok',
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Ticket ID
                      Center(
                        child: Text(
                          'Ticket ID: ${ticketData?['ticketId'] ?? 'N/A'}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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

  /// Builds a card with information rows
  Widget _buildInfoCard(String title, List<Widget> rows) {
    return Card(
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
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...rows,
          ],
        ),
      ),
    );
  }

  /// Builds a single information row
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
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
}

Widget _buildInfoColumn(String title, String value) {
  return Expanded(
    // Wrap each column in Expanded to make sure they don't overflow
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
