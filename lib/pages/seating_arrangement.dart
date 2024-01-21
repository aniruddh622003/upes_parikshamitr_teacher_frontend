import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart'
    show seatingPlan;
import 'package:upes_parikshamitr_teacher_frontend/pages/seating_plan_popup.dart';

class SeatingArrangement extends StatelessWidget {
  const SeatingArrangement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Seating Arrangement',
              style: TextStyle(color: white),
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
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
          const Center(
            child: Text("Mr. Vir Das & Mrs. Richa",
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
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      itemCount: ((int.parse(seatingPlan['data']
                                      ['highest_seat_no']
                                  .substring(1)) +
                              1) *
                          (seatingPlan['data']['highest_seat_no']
                                  .codeUnitAt(0) -
                              'A'.codeUnitAt(0) +
                              2)) as int,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: int.parse(seatingPlan['data']
                                    ['highest_seat_no']
                                .substring(1)) +
                            1,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String highestSeat =
                            seatingPlan['data']['highest_seat_no'];
                        int classSizeH =
                            highestSeat.codeUnitAt(0) - 'A'.codeUnitAt(0) + 2;
                        int classSizeW =
                            int.parse(highestSeat.substring(1)) + 1;
                        int currentRow = index ~/ classSizeW + 1;
                        Color color = blue;
                        String text = '';
                        String seat =
                            String.fromCharCode(64 + index ~/ classSizeW + 1) +
                                (index % classSizeW).toString();
                        int indexData = seatingPlan['data']['seating_plan']
                            .indexWhere(
                                (student) => student['seat_no'] == seat);

                        if (index == (classSizeH - 1) * classSizeW) {
                          color = Colors.transparent;
                        } else if (index % classSizeW == 0 ||
                            currentRow == classSizeH) {
                          color = Colors.transparent;
                          if (index % classSizeW == 0) {
                            text = String.fromCharCode(
                                64 + index ~/ classSizeW + 1);
                          }
                          if (index > classSizeW * (classSizeH - 1)) {
                            text = (index - classSizeW * (classSizeH - 1))
                                .toString();
                          }
                        } else if (indexData > -1) {
                          if (seatingPlan['data']['seating_plan'][indexData]
                                  ['eligible'] ==
                              'YES') {
                            color = blue;
                          } else if (seatingPlan['data']['seating_plan']
                                  [indexData]['eligible'] ==
                              'DEBARRED') {
                            color = red;
                          } else if (seatingPlan['data']['seating_plan']
                                  [indexData]['eligible'] ==
                              'F_HOLD') {
                            color = yellow;
                          }
                        } else {
                          color = gray;
                        }

                        return GestureDetector(
                          onTap: () => indexData > -1
                              ? seatingPlanPopup(
                                  context,
                                  seatingPlan['data']['seating_plan']
                                      [indexData])
                              : {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(text,
                                  style: const TextStyle(
                                      color: black, fontSize: fontMedium)),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text('Seat Allocated'),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text('Seat Debarred'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text('Navigation'),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text('Seat Financial Hold'),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
