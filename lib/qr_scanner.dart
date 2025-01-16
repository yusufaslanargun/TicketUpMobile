import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'ticket_info.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({Key? key}) : super(key: key);

  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        title: const Text('QR Code Scanner',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // QR Scanner View
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),

          // Display Scanned Data or Prompt
          Expanded(
            flex: 1,
            child: Center(
              child: scannedData != null
                  ? Text(
                      'Scanned Data: $scannedData',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  : const Text(
                      'Scan a QR Code',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handles QR code scanning
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    // Listen to the QR code scan stream
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData = scanData.code;
      });

      if (scannedData != null) {
        controller.pauseCamera(); // Pause scanning to avoid multiple triggers
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => TicketInfoPage(scannedData: scannedData!),
          ),
        )
            .then((_) {
          // Resume the camera when returning to this page
          controller.resumeCamera();
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
