import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: MobileScanner(
                onDetect: (capture)async {
                  final Barcode outletId = capture.barcodes[0];
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  final savedOutlets = prefs.getStringList("savedOutlets");
                  if(outletId.rawValue!=null){
                    if(savedOutlets!=null){
                      if(!savedOutlets.contains(outletId.rawValue)){
                        savedOutlets.add(outletId.rawValue!);
                      }
                      await prefs.setStringList("savedOutlets", savedOutlets);
                    }else{
                      await prefs.setStringList("savedOutlets", [outletId.rawValue!]);
                    }
                  }
                  if(context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
            const Text(
              "Scan Outlet QR Code",
              style: TextStyle(
                fontSize: 30
              ),
            )
          ],
        ),
      )
    );
  }
}
