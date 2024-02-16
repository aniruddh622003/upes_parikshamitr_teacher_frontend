import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/mark_ufm.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/custom_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
// import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart' show serverUrl;
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class UFMPage extends StatefulWidget {
  final Map<dynamic, dynamic> studentDetails;
  const UFMPage({super.key, required this.studentDetails});

  @override
  State<UFMPage> createState() => _UFMPageState();
}

class _UFMPageState extends State<UFMPage> {
  int _counter1 = 0;
  int _counter2 = 0;
  int _counter3 = 0;
  int _counter4 = 0;
  TextEditingController controllerFName = TextEditingController();
  TextEditingController controllerFMobile = TextEditingController();
  TextEditingController controllerEAddress = TextEditingController();
  TextEditingController controllerEMobile = TextEditingController();
  TextEditingController controllerOtherRemarks = TextEditingController();
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
  bool _isChecked5 = false;
  bool _isChecked6 = false;
  bool _isChecked7 = false;
  bool _isChecked8 = false;
  bool _isChecked9 = false;
  bool _isChecked10 = false;
  bool _isChecked11 = false;
  bool _isChecked12 = false;
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
                              Text(widget.studentDetails['sap_id'].toString(),
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
                                    widget.studentDetails['seat_no'].toString(),
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
                          Text(widget.studentDetails['roll_no'].toString(),
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Name',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(widget.studentDetails['student_name'].toString(),
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Subject Name',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(widget.studentDetails['subject'].toString(),
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Subject Code',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(widget.studentDetails['subject_code'].toString(),
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Course',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(widget.studentDetails['course'].toString(),
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),
                          const Text('Examination Type',
                              style: TextStyle(
                                  fontSize: fontSmall,
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                          Text(widget.studentDetails['exam_type'].toString(),
                              style: const TextStyle(
                                fontSize: fontMedium,
                              )),

                          // here two text field with father name and contact number

                          const Text('Father\'s Name',
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
                            child: TextField(
                              controller: controllerFName,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type here',
                              ),
                            ),
                          ),
                          const Text('Father\'s Contact Number',
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
                            child: TextField(
                              controller: controllerFMobile,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type here',
                              ),
                            ),
                          ),
                          const Text('Emergency Contact',
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
                            child: TextField(
                              controller: controllerEMobile,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type here',
                              ),
                            ),
                          ),
                          const Text('Contact Address',
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
                            child: TextField(
                              controller: controllerEAddress,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type here',
                              ),
                            ),
                          ),
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
                                const Flexible(
                                  child: Text('No. of printed pages',
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
                                const Flexible(
                                  child: Text('No. of torn pages',
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
                                const Flexible(
                                  child: Text('Communication device',
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  child: Text(
                                      'Number of handwritten pages',
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
                                      Text('$_counter4',
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
                                const Text("In student's shoes",
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
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("In student's pocket",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked3,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked3 = value!;
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
                                const Text("In student's clothes",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked4,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked4 = value!;
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
                                const Text("On table",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked5,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked5 = value!;
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
                                const Text("In answer book",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked6,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked6 = value!;
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
                                const Text("Under answer book",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked7,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked7 = value!;
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
                                const Text("Under question paper",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked8,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked8 = value!;
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
                                const Text("Under feet",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked9,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked9 = value!;
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
                                const Text("In desk",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked10,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked10 = value!;
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
                                const Text("Near desk",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked11,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked11 = value!;
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
                                const Text("Other",
                                    style: TextStyle(fontSize: fontMedium)),
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Checkbox(
                                      value: _isChecked12,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked12 = value!;
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
                            child: TextField(
                              controller: controllerOtherRemarks,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
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
                              onPressed: () async {
                                try {
                                  if (controllerEAddress.text.isNotEmpty &&
                                      controllerEMobile.text.isNotEmpty &&
                                      controllerFMobile.text.isNotEmpty &&
                                      controllerFName.text.isNotEmpty) {
                                    Map data = {
                                      "room_id": "65ba84665bfb4b58d77d0184",
                                      "sap_id": widget.studentDetails['sap_id']
                                          .toString(),
                                      "father_name": controllerFName.text,
                                      "address": controllerEAddress.text,
                                      "mobile": controllerFMobile.text,
                                      "emergency_contact":
                                          controllerEMobile.text,
                                      "incriminating_material": {
                                        "torn_book_pages": _counter2,
                                        "printed_pages": _counter1,
                                        "handwritten_pages": _counter4,
                                        "communication_devices": _counter3
                                      },
                                      "recovered_from": {
                                        "student_hand": _isChecked1,
                                        "student_pocket": _isChecked3,
                                        "student_shoe": _isChecked2,
                                        "student_underclothes": _isChecked4,
                                        "on_table": _isChecked5,
                                        "in_answer_book": _isChecked6,
                                        "under_answer_book": _isChecked7,
                                        "under_question_paper": _isChecked8,
                                        "under_feet": _isChecked9,
                                        "in_desk": _isChecked10,
                                        "near_desk": _isChecked11,
                                        "other": _isChecked12
                                      },
                                      "other_mode_of_misconduct":
                                          controllerOtherRemarks.text
                                    };
                                    dynamic response = await markUFM(data);
                                    if (response != null) {
                                      if (response.statusCode == 201) {
                                        Navigator.pop(context);
                                        customDialog(context, "Success",
                                            "UFM Slip has been issued successfully!");
                                      } else {
                                        Navigator.pop(context);
                                        errorDialog(context, response.body);
                                      }
                                    } else {
                                      Navigator.pop(context);
                                      errorDialog(context, "An error occured!");
                                    }
                                  } else {
                                    Navigator.pop(context);
                                    errorDialog(
                                        context, "Please fill all the fields!");
                                  }
                                } catch (e) {
                                  Navigator.pop(context);
                                  errorDialog(context, e.toString());
                                }
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
