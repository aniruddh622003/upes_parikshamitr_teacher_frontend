import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class UFMPage extends StatefulWidget {
  const UFMPage({super.key});

  @override
  State<UFMPage> createState() => _UFMPageState();
}

class _UFMPageState extends State<UFMPage> {
  int _counter1 = 0;
  int _counter2 = 0;
  int _counter3 = 0;
  int _counter4 = 0;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        foregroundColor: white,
        title: const Text('Issue UFM Slip'),
      ),
      body: Container(
        color: blue,
        child: Column(
          children: [
            const Center(
              child: Text("Room: 11013",
                  style: TextStyle(
                    color: white,
                    fontSize: fontXLarge,
                  )),
            ),
            const Center(
              child: Text("2:00 - 5:00 PM",
                  style: TextStyle(
                    color: white,
                    fontSize: fontSmall,
                  )),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SAP ID',
                                  style: TextStyle(
                                      fontSize: fontSmall,
                                      color: blue,
                                      fontWeight: FontWeight.bold)),
                              Text('Seat No.',
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
                              Text(studentDetails['sap_id'] as String,
                                  style: const TextStyle(fontSize: fontMedium)),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    studentDetails['seat_no'] as String,
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: fontMedium,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Text('Roll No.',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(studentDetails['roll_no'] as String,
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Name',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(studentDetails['student_name'] as String,
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Subject Name',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(studentDetails['subject'] as String,
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Subject Code',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(studentDetails['subject_code'] as String,
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Course',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(studentDetails['course'] as String,
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Examination Type',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(studentDetails['exam_type'] as String,
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text(
                              'Details of incriminating material recovered',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('No. of printed pages',
                                    style: TextStyle(fontSize: fontMedium)),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_counter1 > 0) _counter1--;
                                            });
                                          },
                                          icon: const Icon(Icons.remove,
                                              color: white),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                      Text('$_counter1',
                                          style: const TextStyle(fontSize: 20)),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _counter1++;
                                            });
                                          },
                                          icon: const Icon(Icons.add,
                                              color: white),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('No. of torn pages',
                                    style: TextStyle(fontSize: fontMedium)),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_counter2 > 0) _counter2--;
                                            });
                                          },
                                          icon: const Icon(Icons.remove,
                                              color: white),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                      Text('$_counter2',
                                          style: const TextStyle(fontSize: 20)),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _counter2++;
                                            });
                                          },
                                          icon: const Icon(Icons.add,
                                              color: white),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Communication device',
                                    style: TextStyle(fontSize: fontMedium)),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_counter3 > 0) _counter3--;
                                            });
                                          },
                                          icon: const Icon(Icons.remove,
                                              color: white),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                      Text('$_counter3',
                                          style: const TextStyle(fontSize: 20)),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _counter3++;
                                            });
                                          },
                                          icon: const Icon(Icons.add,
                                              color: white),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                              'Material recovered under reference as below',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("In student's hand",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked1,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked1 = value!;
                                        });
                                      },
                                      activeColor: blue,
                                      checkColor: white,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("In student's shoes or socks",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked2,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked2 = value!;
                                        });
                                      },
                                      activeColor: blue,
                                      checkColor: white,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  child: Text('Near his seat at distance of',
                                      style: TextStyle(fontSize: fontMedium)),
                                ),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_counter4 > 0) _counter4--;
                                            });
                                          },
                                          icon: const Icon(Icons.remove,
                                              color: white),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                      Text('${_counter4}m',
                                          style: const TextStyle(fontSize: 20)),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _counter4++;
                                            });
                                          },
                                          icon: const Icon(Icons.add,
                                              color: white),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                              'Any other mode of use of unfair means or misconduct, if any:',
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
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blue,
                                foregroundColor: white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                // attendancePopup(context);
                              },
                              child: const Text('Report Student',
                                  style: TextStyle(fontSize: fontSmall)),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
