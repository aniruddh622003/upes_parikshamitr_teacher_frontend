// void errorDialog(BuildContext context, String errMsg) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Info",
//                       style: TextStyle(
//                           fontSize: fontLarge, fontWeight: FontWeight.bold)),
//                   Text(errMsg, style: const TextStyle(fontSize: fontMedium)),
//                   const SizedBox(height: 10),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         Navigator.pop(context);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SignInPage()));
//                         // Navigator.pop(context);
//                       },
//                       child: const Text("OK"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }