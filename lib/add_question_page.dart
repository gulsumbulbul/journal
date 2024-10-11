import 'package:flutter/material.dart';
import 'package:journal/change_question.dart';
import 'package:journal/const/color.dart';
import 'package:journal/model/questions.dart';
import 'package:journal/service/question_service.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionService qservice = QuestionService();

  List<Questions?> questions = [];

  ChangeQuestion change = ChangeQuestion();
  var currentId = -1;

  @override
  void initState() {
    super.initState();
    refreshQuestions();
  }

  void refreshQuestions() {
    qservice.getQuestion().then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          questions = value;
          if (questions.isNotEmpty) {
            currentId = questions[0]?.id ?? -1; // Güncel sorunun ID'si
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.silver,
        title: const Text('Question Settings'),
      ),
      backgroundColor: AppColors.silver,
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Card(
              color: AppColors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5.0,
                ),
                title: Text(
                  question?.question ?? 'No Question',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                trailing: Icon(Icons.delete),
                onTap: () async {
                  if (questions.isNotEmpty) {
                    int idToDelete = questions[0]?.id ?? -1;
                    if (idToDelete != -1) {
                      await qservice.deleteQuestions(idToDelete);
                      refreshQuestions();
                      setState(() {});
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? newQuestion = await change.showQuestionDialog(context);
          if (newQuestion != null) {
            await qservice.createQuestions(newQuestion);
            refreshQuestions();
            setState(() {});
          }
        },
        child: Icon(Icons.add), // Artı ikonu
        tooltip: 'Add New Item',
        backgroundColor: AppColors.white,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:journal/change_question.dart';
// import 'package:journal/const/color.dart';
// import 'package:journal/model/questions.dart';
// import 'package:journal/service/question_service.dart';

// class QuestionPage extends StatefulWidget {
//   const QuestionPage({super.key});

//   @override
//   State<QuestionPage> createState() => _QuestionPageState();
// }

// class _QuestionPageState extends State<QuestionPage> {
//   QuestionService qservice = QuestionService();

//   List<Questions?> questions = [];

//   ChangeQuestion change = ChangeQuestion();
//   var currentId = -1;

//   @override
//   void initState() {
//     super.initState();
//     refreshQuestions();
//   }

//   void refreshQuestions() {
//     qservice.getQuestion().then((value) {
//       if (value != null && value.isNotEmpty) {
//         setState(() {
//           questions = value;
//           if (questions.isNotEmpty) {
//             currentId = questions[0]?.id ?? -1; // Güncel sorunun ID'si
//           }
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.silver,
//         title: const Text('Question Settings'),
//       ),
//       backgroundColor: AppColors.silver,
//       body: ListView.builder(
//         itemCount: questions.length,
//         itemBuilder: (context, index) {
//           final question = questions[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//             child: Card(
//               color: AppColors.white,
//               elevation: 1,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 20.0,
//                   vertical: 5.0,
//                 ),
//                 title: Text(
//                   question?.question ?? 'No Question',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 trailing: Icon(Icons.delete),
//                 onTap: () async {
//                   if (questions.isNotEmpty) {
//                     int idToDelete = questions[0]?.id ?? -1;
//                     if (idToDelete != -1) {
//                       await qservice.deleteQuestions(idToDelete);
//                       refreshQuestions();
//                       setState(() {});
//                     }
//                   }
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           String? newQuestion = await change.showQuestionDialog(context);
//           if (newQuestion != null) {
//             await qservice.createQuestions(newQuestion);
//             refreshQuestions();
//             setState(() {});
//           }
//         },
//         child: Icon(Icons.add), // Artı ikonu
//         tooltip: 'Add New Item',
//         backgroundColor: AppColors.white,
//       ),
//     );
//   }
// }
