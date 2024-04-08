import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void detailsPopup(BuildContext context, Map<String, dynamic> details) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Details',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                            fontSize: fontMedium, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Text('Name',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(details['name'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium + 2,
                    )),
                const Text('SAP ID',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(details['sap_id'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('Phone',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(details['phone'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('Email',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(details['email'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
              ],
            ),
          ),
        ),
      );
    },
  );
}
