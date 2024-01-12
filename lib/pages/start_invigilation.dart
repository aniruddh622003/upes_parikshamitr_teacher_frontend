import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_details.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class StartInvigilation extends StatelessWidget {
  const StartInvigilation({super.key});

  @override
  Widget build(BuildContext context) {
    final qrKey = GlobalKey(debugLabel: 'QR');
    void onQRViewCreated(QRViewController controller) {
      controller.scannedDataStream.listen((scanData) {
        controller.pauseCamera();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Scan Successful'),
              content: Text(scanData.code.toString()),
              actions: <Widget>[
                TextButton(
                  child: const Text('Scan Again'),
                  onPressed: () {
                    controller.resumeCamera();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => InvigilationDetails()),
                    );
                  },
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Scan QR Code',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Center(
                child: Text(
                  'Scan QR Code in Controller Room to get your invigilation details and proceed.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: onQRViewCreated,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvigilationDetails()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Can\'t Scan Code? ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      'Type Code.',
                      style: TextStyle(fontSize: 18, color: Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
