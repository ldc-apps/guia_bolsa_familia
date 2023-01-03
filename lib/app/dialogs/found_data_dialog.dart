// import 'dart:ui';

// import 'package:aid_brazil/app/ad/ad_controller.dart';
// import 'package:aid_brazil/app/ad/ad_model.dart';
// import 'package:aid_brazil/app/components/h.dart';
// import 'package:aid_brazil/app/components/stream_out.dart';
// import 'package:aid_brazil/app/components/w.dart';
// import 'package:aid_brazil/app/utils/app_colors.dart';
// import 'package:aid_brazil/app/utils/global_resource.dart';
// import 'package:flutter/material.dart';

// import '../components/button.dart';

// class FoundDataDialog extends StatefulWidget {
//   const FoundDataDialog({Key? key}) : super(key: key);

//   @override
//   State<FoundDataDialog> createState() => _FoundDataDialogState();
// }

// class _FoundDataDialogState extends State<FoundDataDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamOut<AdConfig>(
//       stream: AdController.adConfigStream.listen,
//       child: (_, adConfig) => WillPopScope(
//         onWillPop: () async => false,
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: SimpleDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             contentPadding: const EdgeInsets.all(20),
//             children: [
//               StreamOut<bool>(
//                 stream: adConfig.rewarded.active
//                     ? AdController.rewardedLoadingStream.listen
//                     : (adConfig.intersticialRewarded.active
//                         ? AdController.rewardedIntersticialLoadingStream.listen
//                         : AdController.rewardedLoadingStream.listen),
//                 child: (_, loading) => Column(
//                   children: [
//                     const H(16),
//                     Image.asset('assets/images/found_data.png'),
//                     const H(32),
//                     const Text('Encontramos seus dados!',
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.greenDark)),
//                     const H(8),
//                     const Text(
//                         'Assista um rápido anúncio para ver\no resultado de sua consulta',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: AppColors.greenDark,
//                         )),
//                     const H(32),
//                     SizedBox(
//                       width: double.maxFinite,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 11,
//                             child: Button(
//                               label: empty,
//                               child: loading
//                                   ? const SizedBox(
//                                       width: 12,
//                                       height: 12,
//                                       child: CircularProgressIndicator(
//                                         valueColor:
//                                             AlwaysStoppedAnimation<Color>(
//                                                 Colors.white),
//                                       ),
//                                     )
//                                   : Row(
//                                       children: const [
//                                         Icon(
//                                           Icons.ads_click,
//                                           color: Colors.white,
//                                         ),
//                                         W(6),
//                                         Text('Ver consulta',
//                                             style: TextStyle(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontSize: 18,
//                                                 color: Colors.white))
//                                       ],
//                                     ),
//                               onPressed: () => AdController.showQueryAd(),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 8,
//                             child: Button(
//                               label: 'Agora não',
//                               color: AppColors.white,
//                               textColor: AppColors.beige,
//                               onPressed: () async {
//                                 Navigator.pop(context);
//                                 Navigator.pop(context);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
