import 'package:flutter/material.dart';

class SingleTicketView extends StatelessWidget {
  final Map<String, String> ticket;

  const SingleTicketView({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ticket['title'] ?? 'Ticket Details'),
        backgroundColor: const Color(0xFF222222),
      ),
      body: Center(
        child: SizedBox(
          width:
              MediaQuery.of(context).size.width * 0.9, // Genişliği sınırlayın
          child: Card(
            color: const Color(0xFF444444),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket['title'] ?? 'No Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${ticket['date'] ?? 'Unknown'}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${ticket['location'] ?? 'Unknown'}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
