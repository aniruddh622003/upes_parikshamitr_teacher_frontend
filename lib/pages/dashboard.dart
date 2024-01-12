import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/resizeable_containers.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  List<Widget> makeBatchwiseBars(List<Map<String, dynamic>> batches) {
    List<Widget> batchwiseBars = [];
    for (Map<String, dynamic> batch in batches) {
      batchwiseBars.add(
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${batch['name']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${batch['sheetsEvaluated'].toString()}/${batch['totalSheets'].toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: 8,
                child: LinearProgressIndicator(
                  value: batch['sheetsEvaluated'] / batch['totalSheets'],
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      );
      batchwiseBars.add(const SizedBox(width: 10));
    }
    return batchwiseBars;
  }

  final sheetsData = [
    {
      'subjectCode': 'CSBD1001',
      'subjectName': 'Big Data',
      'dueDate': '2024-01-15',
      'batches': [
        {'name': 'AIML B2 (NH)', 'totalSheets': 30, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    },
    {
      'subjectCode': 'CSAI2036',
      'subjectName': 'Machine Learning',
      'dueDate': '2024-01-20',
      'batches': [
        {'name': 'AIML B1 (NH)', 'totalSheets': 20, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    },
    {
      'subjectCode': 'CSAI1231',
      'subjectName': 'Deep Learning',
      'dueDate': '2024-01-25',
      'batches': [
        {'name': 'AIML B1 (NH)', 'totalSheets': 20, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    }
  ];

  List<int> calcSheets(List<Map<String, dynamic>> sheetsData) {
    List<int> totalSheets = [];
    int total = 0;
    int checked = 0;
    for (Map<String, dynamic> sheetData in sheetsData) {
      for (var batch in sheetData['batches'] as List<Map<String, dynamic>>) {
        checked += batch['sheetsEvaluated'] as int;
        total += batch['totalSheets'] as int;
      }
    }
    totalSheets.add(checked);
    totalSheets.add(total);
    return totalSheets;
  }

  List<Widget> makeSheetCards(List<Map<String, dynamic>> sheetsData) {
    List<Widget> sheetCards = [];
    sheetCards.add(const Text("Evaluate Answer Sheets",
        style: TextStyle(fontWeight: FontWeight.bold)));
    for (Map<String, dynamic> sheetData in sheetsData) {
      final int daysRemaining = DateTime.parse(sheetData['dueDate'].toString())
          .difference(DateTime.now())
          .inDays;
      int totalSheets = 0;
      int sheetsEvaluated = 0;
      for (var batch in sheetData['batches'] as List<Map<String, dynamic>>) {
        totalSheets += batch['totalSheets'] as int;
        sheetsEvaluated += batch['sheetsEvaluated'] as int;
      }
      sheetCards.add(Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 231, 233, 249),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sheetData['subjectCode'].toString()),
                  Text(
                    sheetData['subjectName'].toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Submission in $daysRemaining days'),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$sheetsEvaluated/$totalSheets',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const Divider(color: Colors.grey),
          Column(
              children: makeBatchwiseBars(
                  sheetData['batches'] as List<Map<String, dynamic>>)),
        ]),
      ));
      sheetCards.add(const SizedBox(height: 10));
    }
    return sheetCards;
  }

  Widget makeSheetMain(List<Map<String, dynamic>> sheetsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: makeSheetCards(sheetsData),
    );
  }

  final Widget notificationButton = Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 20, 55, 229),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Notifications()),
        // );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'View Notification',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Text(
              '3',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.account_circle, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Hi, Aarav',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.qr_code, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StartInvigilation()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: Text('Start Invigilation   ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${calcSheets(sheetsData)[0]}/${calcSheets(sheetsData)[1]} Sheets Checked',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          height: 8,
                          child: LinearProgressIndicator(
                            value: calcSheets(sheetsData)[0] /
                                calcSheets(sheetsData)[1],
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.orange),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    children: [
                      notificationButton,
                      const SizedBox(height: 10),
                      const Schedule(),
                      const SizedBox(height: 10),
                      makeSheetMain(sheetsData),
                    ],
                  )),
            ),
          ],
        ));
  }
}
