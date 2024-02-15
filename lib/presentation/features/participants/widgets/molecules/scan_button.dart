import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class ScanButton extends StatelessWidget {
  final dynamic Function(String) onBarcodeScanned;

  const ScanButton({super.key, required this.onBarcodeScanned});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid
        ),
      ),
      width: 60,
      height: 60,
      child: FittedBox(
        fit: BoxFit.contain,
        child: InkWell(
          onTap: scan,
          child: Image.asset("assets/icons/icon_qr_banner.png"),
        ),
      ),
    );
  }

  Future scan() async {
    try {
      ScanResult result = await BarcodeScanner.scan();

      onBarcodeScanned(result.rawContent);
    } catch (e) {
      if (e.toString().contains('PERMISSION_DENIED')) {
        onBarcodeScanned('No se concedió el permiso de la cámara!');
      } else {
        onBarcodeScanned('Error desconocido: $e');
      }
    }
  }
}
