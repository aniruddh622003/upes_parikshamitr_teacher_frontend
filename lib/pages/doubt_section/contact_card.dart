import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/chat.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String designation;
  final VoidCallback onMessagePressed;

  const ContactCard({
    Key? key,
    required this.name,
    required this.designation,
    required this.onMessagePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              personName: name,
              designation: designation,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.blue[50],
        margin: EdgeInsets.all(6),
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(fontSize: fontMedium, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  designation,
                  style: TextStyle(fontSize: fontSmall),
                ),
              ),
              SvgPicture.asset(
                'android/assets/msg.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
