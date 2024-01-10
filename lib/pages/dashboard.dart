import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final sheetsData = [
    {
      'subjectCode': 'CSAI2036',
      'subjectName': 'Machine Learning',
      'dueDate': '2024-01-20',
      'batches': [
        {'name': 'AIML B1 (NH)', 'totalSheets': 20, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    },
    {
      'subjectCode': 'CSAI2036',
      'subjectName': 'Machine Learning',
      'dueDate': '2024-01-20',
      'batches': [
        {'name': 'AIML B1 (NH)', 'totalSheets': 20, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    },
    {
      'subjectCode': 'CSAI2036',
      'subjectName': 'Machine Learning',
      'dueDate': '2024-01-20',
      'batches': [
        {'name': 'AIML B1 (NH)', 'totalSheets': 20, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    }
  ];

  List<Widget> makeSheetCards(List<Map<String, dynamic>> sheetsData) {
    List<Widget> sheetCards = [];
    for (var sheetData in sheetsData) {
      sheetCards.add();
    }
    return sheetCards;
  }

  final Widget notificationButton = Container(
    height: 45,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
    ),
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
  );
  List<Container> makeDateWidgets(List<String> dates) {
    List<Container> dateWidgets = [];
    for (String date in dates) {
      dateWidgets.add(
        Container(
          width: 65,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 231, 233, 249),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.split('-')[0],
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
              Text(
                date.split('-')[1],
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );
      dateWidgets.add(Container(child: const SizedBox(width: 10)));
    }
    return dateWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final sheetData = {
      'subjectCode': 'CSAI2036',
      'subjectName': 'Machine Learning',
      'dueDate': '2024-01-20',
      'batches': [
        {'name': 'AIML B1 (NH)', 'totalSheets': 20, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    };
    final dueDate = DateTime.parse(sheetData['dueDate'].toString());
    final currentDate = DateTime.now();
    final difference = dueDate.difference(currentDate).inDays;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Container(
              height: 200,
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "View Invigilation Schedule",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: makeDateWidgets([
                                '31-Dec',
                                '1-Jan',
                                '2-Jan',
                                '3-Jan',
                                '4-Jan',
                                '5-Jan',
                                '6-Jan',
                                '7-Jan',
                              ]),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 130,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 233, 249),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 233, 249),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 233, 249),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Evaluate Answer Sheets",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 233, 249),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(sheetData['subjectCode'].toString()),
                                      Text(
                                        sheetData['subjectName'].toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Submission in $difference days'),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      '5/10',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(color: Colors.grey),
                              Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Batch 1',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '2/5',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: SizedBox(
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: 2 / 5,
                                        backgroundColor: Colors.grey[200],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Batch 1',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '2/5',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: SizedBox(
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: 2 / 5,
                                        backgroundColor: Colors.grey[200],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Batch 1',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '2/5',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: SizedBox(
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: 2 / 5,
                                        backgroundColor: Colors.grey[200],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
