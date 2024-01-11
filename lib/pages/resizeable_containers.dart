import 'package:flutter/material.dart';

class ResizableContainers extends StatefulWidget {
  const ResizableContainers({super.key});
  @override
  _ResizableContainersState createState() => _ResizableContainersState();
}

class _ResizableContainersState extends State<ResizableContainers> {
  int selectedContainerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // Replace with your number of containers
      itemBuilder: (context, index) {
        List<Map> data = [
          {
            'timeSlot': '9 AM - 12 PM',
            'task': 'Invigilation Duty',
            'room': 'Controller Room',
            'message':
                'Go to the controller room, press start invigilation and scan the QR for further  instructions'
          },
          {
            'timeSlot': '12 PM - 1 PM',
            'task': 'Lunch Break',
            'room': 'Cafeteria',
            'message':
                'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
          },
          {
            'timeSlot': '1 PM - 4 PM',
            'task': 'Invigilation Duty',
            'room': 'Controller Room',
            'message':
                'Go to the controller room, press start invigilation and scan the QR for further  instructions'
          },
        ];
        Color selectedColorBG = const Color(0xff6E83DB);
        Color baseColorBG = const Color(0xffC2C9F0);
        Color selectedColorText = const Color(0xffffffff);
        Color baseColorText = const Color(0xff000000);
        Color bgColor =
            (selectedContainerIndex == index) ? selectedColorBG : baseColorBG;
        Color textColor = (selectedContainerIndex == index)
            ? selectedColorText
            : baseColorText;
        Widget contents = (selectedContainerIndex == index)
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data[index]['timeSlot'],
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          data[index]['room'],
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data[index]['task'],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${data[index]['message']}',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data[index]['timeSlot'],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      data[index]['task'],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedContainerIndex = index;
            });
          },
          child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: bgColor,
              ),
              child: contents),
        );
      },
    );
  }
}
