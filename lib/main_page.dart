import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:journal/service/answer_service.dart';
import 'package:journal/model/answers.dart';
import 'package:journal/date_picker.dart';
import 'package:journal/service/emotion_service.dart';
import 'package:journal/model/emotions.dart';
import 'package:journal/journal.dart';
import 'package:journal/profile.dart';
import 'package:journal/store/journal_store.dart';
import 'const/color.dart';
import 'mood_board.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final JournalStore store = JournalStore();

  AnswerService aservice = AnswerService();
  EmotionService eservice = EmotionService();

  List<Answers?> answers = [];
  List<Emotions?> emotions = [];

  int? selectedEmotionIndex; // Seçilen butonun indeksi

  @override
  void initState() {
    super.initState();
    _fetchAnswers(store.selectedDate);
    _fetchEmotions();
  }

  void _fetchAnswers(DateTime date) {
    aservice.getTodayAnswers(date).then((value) {
      setState(() {
        answers = value;
      });
    }).catchError((error) {
      print('Error fetching answers: $error');
    });
  }

  void _fetchEmotions() {
    eservice.getEmotions().then((value) {
      if (value != null && value.isNotEmpty) {
        emotions = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSelector(
              store: store,
            ),
            SizedBox(height: 8),
            Text(
              'How are you\nfeeling today?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: emotions.isNotEmpty
                    ? emotions.asMap().entries.map((entry) {
                        int index = entry.key;
                        Emotions? emotion = entry.value;
                        return emotion != null
                            ? MoodButton(
                                emotionName:
                                    emotion.emotionName ?? "No Emotion",
                                isSelected: selectedEmotionIndex == index,
                                onTap: () {
                                  setState(() {
                                    selectedEmotionIndex =
                                        index; // Seçilen butonun indeksini güncelle
                                  });
                                },
                              )
                            : SizedBox();
                      }).toList()
                    : [Text("No Emotions Available")],
              ),
            ),
            SizedBox(height: 33),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Today's Receiptify",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Observer(
              builder: (_) {
                _fetchAnswers(store.selectedDate);
                return Expanded(
                  child: answers.isNotEmpty
                      ? ListView.builder(
                          itemCount: answers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "${answers[index]?.answer}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                "There is no journal entry for the selected day.",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            SizedBox(height: 11),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JournalPage(
                        date: store.selectedDate,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Start Journal',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
