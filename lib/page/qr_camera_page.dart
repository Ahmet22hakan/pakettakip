import 'package:PrimeTasche/controller/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PrimeTasche/controller/input_controller.dart';
import 'package:PrimeTasche/main.dart';
import 'package:PrimeTasche/route_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCameraPage extends StatelessWidget {
  const QrCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              container.read(languageProvider).isEnglish?
              "Scan a QR code":
              "Taschen Barcode scanner",
              style: GoogleFonts.openSans(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: SafeArea(child: QRView(key: qrKey, onQRViewCreated: onQRViewCreated)),
      ),
    );
  }

  void onQRViewCreated(QRViewController p1) {
    p1.scannedDataStream.listen((scanData) {
      container.read(inputProvider).qr.text = scanData.code ?? "";
      print("qr=>${scanData.code}");

      if (container.read(routeProvider).location != "/bagadd" &&
          container.read(routeProvider).location != "/cantateslimet" &&
          container.read(routeProvider).location != "/cantateslimal" &&
          container.read(routeProvider).location != "/qrislem") {
        container.read(routeProvider).pop();
      }
    });
  }
}
