import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? qrController;
  String qrResult = "No QR code scanned";
  XFile? image;

  @override
  void dispose() {
    // qrController?.dispose();
    super.dispose();
  }

  // void _scanQRCode() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         height: 300,
  //         padding: EdgeInsets.all(16),
  //         child: Column(
  //           children: [
  //             Expanded(
  //               child: QRView(
  //                 key: qrKey,
  //                 onQRViewCreated: (QRViewController controller) {
  //                   setState(() => qrController = controller);
  //                   controller.scannedDataStream.listen((scanData) {
  //                     setState(() => qrResult = scanData.code ?? "Invalid QR");
  //                     Navigator.pop(context);
  //                   });
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _captureCard() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() => image = pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Business Card')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.qr_code, color: Colors.teal),
                title: Text("Scan QR Code"),
                // onTap: _scanQRCode,
              ),
            ),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.teal),
                title: Text("Capture Business Card"),
                // onTap: _captureCard,
              ),
            ),

            if (image != null) ...[
              SizedBox(height: 16),
              Text("Captured Image:", style: TextStyle(fontWeight: FontWeight.bold)),
              Image.network(image!.path, height: 200),
            ],

            SizedBox(height: 16),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.edit, color: Colors.teal),
                title: Text("Enter Details Manually"),
                onTap: () {
                  // Navigate to manual entry form
                },
              ),
            ),

            SizedBox(height: 16),

            // Text("QR Scan Result: $qrResult"),
          ],
        ),
      ),
    );
  }
}
