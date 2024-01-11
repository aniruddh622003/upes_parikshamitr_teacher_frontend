import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/resizeable_containers.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ResizableContainers(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Col, col, lv, ex, cont, col