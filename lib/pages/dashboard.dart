import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
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
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 64, 255),
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
                                '4-Jan'
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
                            height: 140,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 233, 249),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 140,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 233, 249),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 140,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 233, 249),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
