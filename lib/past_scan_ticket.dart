import 'package:flutter/material.dart';
import 'bottom_bar.dart';

class TicketListPage extends StatefulWidget {
  const TicketListPage({super.key});

  @override
  _TicketListPageState createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  // Dummy lists of tickets
  final List<Map<String, String>> createdTickets = [
    {
      'title': 'Concert Ticket',
      'date': '2025-01-10',
      'location': 'Music Hall A',
    },
    {
      'title': 'Movie Ticket',
      'date': '2025-01-15',
      'location': 'Cinema B',
    },
    {
      'title': 'Seminar Entry',
      'date': '2025-02-01',
      'location': 'Conference Center C',
    },
  ];

  final List<Map<String, String>> scannedTickets = [
    {
      'title': 'Event Entry',
      'date': '2025-01-05',
      'location': 'Expo Center D',
    },
    {
      'title': 'Workshop Pass',
      'date': '2025-01-20',
      'location': 'Workshop Hall E',
    },
  ];

  bool showCreatedTickets = true;

  void showTicketDetails(Map<String, String> ticket) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF444444),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            ticket['title']!,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: ${ticket['date']}',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Location: ${ticket['location']}',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

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
    final tickets = showCreatedTickets ? createdTickets : scannedTickets;

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
            const Text('Geçmiş', style: TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Section Tabs
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showCreatedTickets = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: showCreatedTickets
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFD6125E),
                                    Color(0xFFFEA473)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                              : null,
                          color: !showCreatedTickets
                              ? const Color(0xFF444444)
                              : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Oluşturulan Biletler',
                            style: TextStyle(
                              color: showCreatedTickets
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showCreatedTickets = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: !showCreatedTickets
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFD6125E),
                                    Color(0xFFFEA473)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                              : null,
                          color: showCreatedTickets
                              ? const Color(0xFF444444)
                              : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Taranmış Biletler',
                            style: TextStyle(
                              color: !showCreatedTickets
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Ticket List
          Expanded(
            child: tickets.isEmpty
                ? const Center(
                    child: Text(
                      'No tickets found.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return GestureDetector(
                        onTap: () => showTicketDetails(ticket),
                        child: Card(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                      );
                    },
                  ),
          ),
          SizedBox(height: 40),
        ],
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
