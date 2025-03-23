import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String scannedUID = 'not scanned';
  final MobileScannerController controller = MobileScannerController();
  bool _isPopping = false; // Flag to prevent multiple pops

  @override
  void initState() {
    super.initState();
    // Start the camera when the widget is initialized
    controller.start().catchError((error) {
      // Handle camera start errors
      print("Failed to start camera: $error");
    });
  }



  // Handle the QR scan and pass the UID back to the previous screen
  void handleQR(BarcodeCapture capture) {
    if (capture.barcodes.isNotEmpty && !_isPopping) {
      setState(() {
        scannedUID = capture.barcodes.first.rawValue ?? 'no value';
      });

      // Prevent multiple pops
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
              width: 250, // Set width
              height: 250, // Set height
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3), // Optional border
                borderRadius: BorderRadius.circular(12), // Optional rounded corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Match border radius
                child: MobileScanner(
                  controller: controller, // Use the controller for camera control
                  fit: BoxFit.cover, // Ensures the camera feed fits inside the box
                  onDetect: handleQR, // Set callback to handle QR detection
                ),
              ),
            ),
            SizedBox(height: 20), // Add some spacing
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