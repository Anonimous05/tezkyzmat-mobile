// import 'package:flutter/material.dart';

// class CustomDialog extends StatelessWidget {
//   const CustomDialog({
//     super.key,
//     required this.title,
//     required this.confirmButtonText,
//     required this.cancelButtonText,
//     required this.onConfirm,
//     required this.onCancel,
//     this.isDelete = false,
//   });
//   final String title;
//   final String confirmButtonText;
//   final String cancelButtonText;
//   final VoidCallback onConfirm;
//   final VoidCallback onCancel;
//   final bool isDelete;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextButton(
//                     onPressed: onCancel,
//                     child: Text(
//                       cancelButtonText,
//                       style: const TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: TextButton(
//                     onPressed: onConfirm,
//                     style: TextButton.styleFrom(
//                       backgroundColor: isDelete ? Colors.red : Colors.blue,
//                     ),
//                     child: Text(
//                       confirmButtonText,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
