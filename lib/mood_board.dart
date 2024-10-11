import 'package:flutter/material.dart';
import 'package:journal/const/color.dart';

class MoodButton extends StatelessWidget {
  final String emotionName;
  final bool isSelected;
  final VoidCallback onTap;

  MoodButton({
    required this.emotionName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.black : AppColors.white,
        side: BorderSide(
          color: isSelected ? AppColors.white : AppColors.red,
        ),
      ),
      child: Column(
        children: [
          Text(
            emotionName,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:journal/const/color.dart';

// class MoodButton extends StatefulWidget {
//   final String emotionName;

//   MoodButton({
//     required this.emotionName,
//   });

//   @override
//   State<MoodButton> createState() => _MoodButtonState();
// }

// class _MoodButtonState extends State<MoodButton> {
//   bool _isClicked = false;

//   void isClicked() {
//     setState(() {
//       _isClicked = !_isClicked;
//     });
//   } //tıklandığında tersine çevirme

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         isClicked();
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: _isClicked ? AppColors.black : AppColors.white,
//         side: BorderSide(
//           color: _isClicked ? AppColors.white : AppColors.red,
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             widget.emotionName,
//             style: TextStyle(
//                 color: _isClicked ? AppColors.white : AppColors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }
