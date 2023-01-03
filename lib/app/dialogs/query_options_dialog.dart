// import 'dart:ui';

// import 'package:aid_brazil/app/ad/ad_controller.dart';
// import 'package:aid_brazil/app/components/h.dart';
// import 'package:aid_brazil/app/components/stream_out.dart';
// import 'package:aid_brazil/app/components/w.dart';
// import 'package:aid_brazil/app/utils/app_colors.dart';
// import 'package:aid_brazil/app/utils/global_resource.dart';
// import 'package:flutter/material.dart';

// import '../components/button.dart';

// class QueryOptionsDialog extends StatefulWidget {
//   const QueryOptionsDialog({Key? key}) : super(key: key);

//   @override
//   State<QueryOptionsDialog> createState() => _QueryOptionsDialogState();
// }

// class _QueryOptionsDialogState extends State<QueryOptionsDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: SimpleDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           contentPadding: const EdgeInsets.all(20),
//           children: [
//             StreamOut<bool>(
//               stream: AdController.rewardedLoadingStream.listen,
//               child: (_, loading) => Column(
//                 children: [
//                   Image.asset('assets/images/more_options.gif'),
//                   const Text('Mais opções de consulta',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.greenDark)),
//                   const H(8),
//                   const Text(
//                       'Assista um anúncio e encontre mais opções de consulta e informação.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: AppColors.green,
//                       )),
//                   const H(32),
//                   SizedBox(
//                     width: double.maxFinite,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Button(
//                             label: 'VOLTAR',
//                             color: AppColors.white,
//                             textColor: AppColors.beige,
//                             onPressed: () async {
//                               Navigator.pop(context);
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           flex: 5,
//                           child: Button(
//                             label: empty,
//                             child: loading
//                                 ? const SizedBox(
//                                     width: 12,
//                                     height: 12,
//                                     child: CircularProgressIndicator(
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                           Colors.white),
//                                     ),
//                                   )
//                                 : Row(
//                                     children: const [
//                                       Icon(
//                                         Icons.ads_click,
//                                         color: Colors.white,
//                                       ),
//                                       W(6),
//                                       Text('VER ANÚNCIO',
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               color: Colors.white))
//                                     ],
//                                   ),
//                             onPressed: () => AdController.showRewardAd(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
