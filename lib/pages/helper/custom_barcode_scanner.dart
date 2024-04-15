import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CustomBarcodeScanner extends StatefulWidget {
  final Function(String) onBarcodeScanned;
  const CustomBarcodeScanner({super.key, required this.onBarcodeScanned});

  @override
  State<CustomBarcodeScanner> createState() => _CustomBarcodeScannerState();
}

class _CustomBarcodeScannerState extends State<CustomBarcodeScanner>
    with WidgetsBindingObserver {
  final MobileScannerController controller =
      MobileScannerController(detectionSpeed: DetectionSpeed.unrestricted);

  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
        if (_barcode != null) {
          controller.stop();
          widget.onBarcodeScanned(_barcode!.displayValue.toString());
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: _handleBarcode,
          // fit: BoxFit.cover,
        ),
      ],
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.stop();
  }
}
