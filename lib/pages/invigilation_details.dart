import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_details_card.dart';

class InvigilationDetails extends StatelessWidget {
  InvigilationDetails({super.key});
  final List<bool> isSelected = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details',
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
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome, <username>',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const InvigilationDetailsCard(),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                for (int i = 0; i < 3; i++)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected[i] = !isSelected[i];
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      margin: const EdgeInsets.all(5),
                                      color: isSelected[i]
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: isSelected.contains(false)
                                          ? null
                                          : () {
                                              // Handle button press
                                            },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                isSelected.contains(false)
                                                    ? Colors.grey
                                                    : Colors.blue),
                                      ),
                                      child: const Text('Button'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                      ),
                                      child: const Text('Back'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Request for Approval',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Dashboard()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Background color
                  foregroundColor: Colors.white, // Text color
                  side: const BorderSide(
                      color: Colors.white, width: 2), // Border color and width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Change Invigilation (3 left)',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
