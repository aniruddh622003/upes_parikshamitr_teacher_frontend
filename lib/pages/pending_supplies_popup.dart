import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void pendingSuppliesPopup(
    BuildContext context, Map<dynamic, dynamic> supplyDetails) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Pending Supplies Detail',
                        style: TextStyle(
                            fontSize: fontMedium, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Supplies Pending',
                        style: TextStyle(
                            fontSize: fontSmall,
                            color: blue,
                            fontWeight: FontWeight.bold)),
                    Text('Pending',
                        style: TextStyle(
                            fontSize: fontSmall,
                            color: blue,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(supplyDetails['name'] as String,
                        style: const TextStyle(fontSize: fontMedium)),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          (supplyDetails['required'] -
                                  supplyDetails['received'])
                              .toString(),
                          style: const TextStyle(
                            color: white,
                            fontSize: fontMedium,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Text('Total Needed',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(supplyDetails['required'].toString(),
                    style: const TextStyle(fontSize: fontMedium)),
                const Text('Total Received',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(supplyDetails['received'].toString(),
                    style: const TextStyle(fontSize: fontMedium)),
                const Text('Update Total Received',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: blueXLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here',
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Confirm Update',
                        style: TextStyle(fontSize: fontSmall)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
