import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class InvigilationDetailsCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  const InvigilationDetailsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Map<String, int> subjectCounts = {'Subject 1': 10, 'Subject 2': 5};

    // for (var student in data['room']['students']) {
    //   if (!subjectCounts.containsKey(student['course'])) {
    //     subjectCounts[student['course']] = 1;
    //   } else {
    //     subjectCounts[student['course']] = 1;
    //   }
    // }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Invigilation Details:',
                style: TextStyle(
                    fontSize: fontLarge,
                    fontWeight: FontWeight.bold,
                    color: blue)),
            const SizedBox(height: 20),
            const Center(
                child:
                    Text('Room No.', style: TextStyle(fontSize: fontMedium))),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  data['room']['room_no'].toString(),
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontMedium,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Examination Subjects'),
            //         Map<String, int> subjectCounts = {};

            // for (Student student in students) {
            //   if (!subjectCounts.containsKey(student.subject)) {
            //     subjectCounts[student.subject] = 1;
            //   } else {
            //     subjectCounts[student.subject] = subjectCounts[student.subject]! + 1;
            //   }
            // }
            Flexible(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  String subject = 'test';
                  int count = 2;
                  print('$subject, $count');
                  return ListTile(
                    title: Text(subject),
                    trailing: Text('$count'),
                  );
                },
              ),
            ),

            // Container(
            //   margin: const EdgeInsets.only(bottom: 10),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     color: blueXLight,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //         decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.vertical(
            //             top: Radius.circular(15),
            //           ),
            //           color: blue,
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text(
            //               'B.Tech CSE AIML 2nd Year',
            //               style: TextStyle(color: white, fontSize: fontSmall),
            //             ),
            //             Container(
            //               width: 25,
            //               height: 25,
            //               decoration: const BoxDecoration(
            //                 color: white,
            //                 shape: BoxShape.circle,
            //               ),
            //               child: const Center(
            //                 child: Text(
            //                   '12',
            //                   style: TextStyle(
            //                     color: blue,
            //                     fontSize: fontSmall,
            //                   ),
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //       Container(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //         child: const Text('Neural Networks',
            //             style: TextStyle(
            //               color: blue,
            //               fontSize: fontMedium,
            //             )),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(bottom: 10),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     color: blueXLight,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //         decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.vertical(
            //             top: Radius.circular(15),
            //           ),
            //           color: blue,
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text(
            //               'BCA AIML 3rd Year',
            //               style: TextStyle(color: white, fontSize: fontSmall),
            //             ),
            //             Container(
            //               width: 25,
            //               height: 25,
            //               decoration: const BoxDecoration(
            //                 color: white,
            //                 shape: BoxShape.circle,
            //               ),
            //               child: const Center(
            //                 child: Text(
            //                   '10',
            //                   style: TextStyle(
            //                     color: blue,
            //                     fontSize: fontSmall,
            //                   ),
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //       Container(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //         child: const Text(
            //             'Containerization and Virtualization Technologies',
            //             style: TextStyle(
            //               color: blue,
            //               fontSize: fontMedium,
            //             )),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text('Co-Invigilator'),
            const Text('Dr. Aryan Sharma',
                style: TextStyle(
                  fontSize: fontMedium,
                  color: orange,
                )),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Students'),
                Text('Debarred Students'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('22',
                    style: TextStyle(
                      fontSize: fontMedium,
                      color: orange,
                    )),
                Text('3',
                    style: TextStyle(
                      fontSize: fontMedium,
                      color: orange,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
