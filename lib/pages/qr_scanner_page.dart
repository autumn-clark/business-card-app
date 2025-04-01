import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String scannedUID = 'not scanned';
  final MobileScannerController controller = MobileScannerController();
  bool _isPopping = false;

  @override
  void initState() {
    super.initState();
    controller.start().catchError((error) {
      print("Failed to start camera: $error");
    });
  }



  void handleQR(BarcodeCapture capture) {
    if (capture.barcodes.isNotEmpty && !_isPopping) {
      setState(() {
        scannedUID = capture.barcodes.first.rawValue ?? 'no value';
      });

      _isPopping = true;
        controller.stop();
        controller.dispose();
        Navigator.pop(context, scannedUID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR Code")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MobileScanner(
                  controller: controller,
                  fit: BoxFit.cover,
                  onDetect: handleQR,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Scanned UID: $scannedUID',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}