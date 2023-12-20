import 'dart:convert';

import 'package:check_point/main.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:camera/camera.dart';
import 'data_parsing.dart';
import 'dateBase.dart';

class QRScannerPage extends StatefulWidget {
  final User user;

  QRScannerPage({required this.user});
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey _qrKey = GlobalKey();
  late QRViewController _controller;
  bool _isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller.scannedDataStream.listen((Barcode scanData) async {
        // Обработка данных после сканирования
        print('QR Code Data: ${scanData.code}');
        if (_isScanning) {
          _controller.pauseCamera();
          _isScanning = false;
        }
        await NalogRuSession(scanData.code.toString());

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainPage(user: widget.user)),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}