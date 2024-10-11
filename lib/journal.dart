import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/service/answer_service.dart';
import 'package:journal/const/color.dart';
import 'package:journal/service/question_service.dart';
import 'package:journal/model/questions.dart';
import 'change_question.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key, required DateTime date});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  QuestionService qservice = QuestionService();
  AnswerService aservice = AnswerService();

  List<Questions?> questions = [];

  ChangeQuestion change = ChangeQuestion(); //soru ekleme ekranı

  late final DateTime date;
  final TextEditingController tfController = TextEditingController();
  var currentId = -1;

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
  void initState() {
    super.initState();
    date = DateTime.now();

    refreshQuestions();
  }

  @override
  Widget build(BuildContext context) {
    //yeni açıldığında günün tarihini göster
    String formattedDate = DateFormat('EEEE, MMMM d').format(date);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          "Today's Journal",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),
            if (questions.isNotEmpty)
              Text(
                "${questions[0]?.question ?? 'No question'}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              const Text(
                'No questions available.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      questions.add(questions.removeAt(0));
                      currentId = questions[0]?.id ?? -1;
                    });
                  },
                  shape: CircleBorder(), // Butonun şekli
                  padding: EdgeInsets.all(8.0), // İkonun etrafındaki boşluk
                  elevation: 0, // Gölgelendirme seviyesi
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //         child: ElevatedButton(
            //             style: ElevatedButton.styleFrom(
            //               backgroundColor: AppColors.silver,
            //             ),
            //             onPressed: () {
            //               setState(() {
            //                 // Soruları sırayla değiştir
            //                 questions.add(questions.removeAt(0));
            //                 currentId = questions[0]?.id ?? -1;
            //               });
            //             },
            //             child: Text(
            //               "change questions",
            //               style: TextStyle(
            //                   color: AppColors.darkBlue,
            //                   fontWeight: FontWeight.bold),
            //             ))),
            //   ],
            // ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: tfController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Write your answer...',
                ),
                maxLines: null,
                expands: false,
                onChanged: (text) {},
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      onPressed: () async {
                        await aservice.createAnswer(date, 1, tfController.text);
                        print(currentId);
                      },
                      child: Text("finish journal",
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
