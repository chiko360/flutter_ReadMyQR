import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:readmyqr/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Scanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Barcode result;
  bool _flashOn = false;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var height = displayHeight(context);
    var width = displayWidth(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.switch_camera_rounded,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await controller?.flipCamera();
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: _flashOn
                      ? Icon(
                          Icons.flash_on_rounded,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.flash_off_rounded,
                          color: Colors.black,
                        ),
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(() {
                      _flashOn = !_flashOn;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        body: _buildQrView(context, height, width),
      ),
    );
  }

  Widget _buildQrView(BuildContext context, height, width) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).orientation.index == 0)
        ? width / 2
        : height / 2;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        await controller?.pauseCamera();
        showAlertDialog(context, result);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context, Barcode result) {
    // Create button
    RegExp exp =
        new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Widget okButton = TextButton(
      child: Text("Copy"),
      onPressed: () async {
        await controller?.resumeCamera();
        Clipboard.setData(
          new ClipboardData(text: result.code),
        );
        Navigator.of(context).pop();
      },
    );
    Widget webButton = TextButton(
      child: Text("Open in browser"),
      onPressed: () async {
        Navigator.of(context).pop();
        if (await canLaunch(result.code)) await launch(result.code);
      },
    );
    Widget cancel = TextButton(
      child: Text("cancel"),
      onPressed: () async {
        await controller?.resumeCamera();
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("found a ${result.format.formatName}"),
      content: Text(result.code),
      actions: [
        exp.hasMatch(result.code) ?? webButton,
        okButton,
        cancel,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
