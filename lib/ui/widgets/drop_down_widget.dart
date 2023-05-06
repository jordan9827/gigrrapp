// import 'package:flutter/material.dart';
//
// import '../../others/constants.dart';
// import '../../util/others/size_config.dart';
//
// class CustomDropDownWidget extends StatelessWidget {
//   final String hintText;
//   final bool isLoading;
//   final Object? initialValue;
//   final Function(Object?)? onChanged;
//   final List<DropdownMenuItem<Object>>? items;
//   const CustomDropDownWidget({
//     Key? key,
//     required this.hintText,
//     this.initialValue,
//     this.isLoading = false,
//     this.onChanged,
//     this.items,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     return DropdownButtonFormField(
//       value: initialValue,
//       menuMaxHeight: SizeConfig.margin_padding_50 * 5,
//       icon: SizedBox(),
//       decoration: InputDecoration(
//         counterText: '',
//         labelStyle: const TextStyle(color: Colors.black),
//         contentPadding: EdgeInsets.all(10),
//         hintText: hintText,
//         fillColor: mainGrayColor,
//         suffixIcon: Container(
//           width: SizeConfig.margin_padding_20,
//           height: SizeConfig.margin_padding_20,
//           padding: EdgeInsets.all(SizeConfig.margin_padding_15),
//           child: isLoading
//               ? CircularProgressIndicator(
//                   color: independenceColor,
//                   strokeWidth: 2.5,
//                 )
//               : Image.asset(
//                   'assets/images/arrow-drop_down.png',
//                 ),
//         ),
//         filled: true,
//         hintStyle: TextStyle(
//           color: textRegularColor,
//         ),
//         errorBorder: inputBorder,
//         border: inputBorder,
//         focusedBorder: inputBorder,
//         enabledBorder: inputBorder,
//       ),
//       onChanged: onChanged,
//       items: items,
//     );
//   }
// }
